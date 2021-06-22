import UIKit
import GoogleMobileAds

final class TopViewController: UIViewController {
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var startButton: UIButton!
    private var settingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        checkSegueSetting()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)
    }
    
//    @IBAction func debug(_ sender: Any) {
//        UserDefaults.standard.removeObject(forKey: .sixTaskListKey)
//        UserDefaults.standard.removeObject(forKey: .HistoryKey)
//        UserDefaults.standard.removeObject(forKey: .sumOfCompletionKey)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAutomaticalTransition()
    }

    @IBAction private func tapStart(_ sender: Any) {
        if UserDefaults.standard.object(forKey: .sixTaskListKey) == nil{
            self.presentNewTaskAlert(topVC: self)
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
