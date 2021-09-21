import UIKit
import GoogleMobileAds

final class TopViewController: UIViewController {
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var startButton: UIButton!
    private var settingButton: UIBarButtonItem!
    
    private var emergency = false
    
    private let shadeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        checkSegueSetting()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)
        
        // クラッシュ数爆増への緊急対応
        emergency = UserDefaults.standard.bool(forKey: "emergency")
        if !emergency {
            emergency = true
            UserDefaults.standard.setValue(emergency, forKey: "emergency")
            debug()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeShadeView), name: .modalClosed, object: nil)
        
    }
    
    @objc func removeShadeView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.shadeView.alpha = 0
        }) { (done) in
            if done {
                self.shadeView.removeFromSuperview()
            }
        }
    }
    
    private func debug() {
        UserDefaults.standard.removeObject(forKey: .sixTaskListKey)
        UserDefaults.standard.removeObject(forKey: .HistoryKey)
        UserDefaults.standard.removeObject(forKey: .sumOfCompletionKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAutomaticalTransition()
    }

    @IBAction private func tapStart(_ sender: Any) {
        if UserDefaults.standard.object(forKey: .sixTaskListKey) == nil{
            
            let vc = SelectModalViewController.instantiate()
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.titleText = "まだタスクを設定していません。\n新たにタスクを設定しますか？"
            self.present(vc, animated: true, completion: nil)
            
            shadeView.backgroundColor = .black
            shadeView.alpha = 0
            self.view.addSubview(shadeView)
            UIView.animate(withDuration: 0.2) {
                self.shadeView.alpha = 0.3
            }
        } else {
            performSegue(withIdentifier: .showSeeVCKey, sender: nil)
        }
    }
    
    @objc private func tapSetting(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: .showSettingVCKey, sender: nil)
    }
    
    private func checkSegueSetting() {
        guard let settingOfShowSeeVCIsOn = UserDefaults.standard.object(forKey: .SettingOfshowSeeVCKey),
              UserDefaults.standard.object(forKey: .sixTaskListKey) != nil
              else { return }
        if settingOfShowSeeVCIsOn as! Bool {
            performSegue(withIdentifier: .showSeeVCKey, sender: nil)
        }
    }
    
    private func checkAutomaticalTransition() {
        // SeeViewControllerまたはInputViewControllerから遷移してきたときには、自動的に他のVCに遷移する。
        if UserDefaults.standard.object(forKey: .fromSeeVCKey) != nil {
            UserDefaults.standard.removeObject(forKey: .fromSeeVCKey)
            performSegue(withIdentifier: .showInputVCKey, sender: nil)
        }
        if UserDefaults.standard.object(forKey: .fromInputVCKey) != nil {
            UserDefaults.standard.removeObject(forKey: .fromInputVCKey)
            performSegue(withIdentifier: .showSeeVCKey, sender: nil)
        }
    }
    
    private func setUpView(){
        self.overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.20, green: 0.23, blue: 0.36, alpha: 1.0)
        self.navigationItem.backButtonTitle = "戻る"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = VCType.top.navigationTitle
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        settingButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(tapSetting(_:)))
        self.navigationItem.rightBarButtonItem = settingButton
        
        startButton.layer.cornerRadius = 5
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowRadius = 5
        startButton.layer.shadowOffset = .zero
        startButton.layer.shadowOpacity = 0.3
    }
    
}

extension TopViewController: CatchModalActionDelegate {
    func catchModalAction() {
        performSegue(withIdentifier: .showInputVCKey, sender: nil)
    }
}
