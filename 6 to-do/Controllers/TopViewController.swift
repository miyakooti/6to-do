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
        BannerSetUpper.setUpBanner(bannerView: bannerView, viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkAutomaticalTransition()
    }

    @IBAction private func tapStart(_ sender: Any) {
        if UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.sixTaskListKey) == nil{
            AlertPresenter.presentNewTaskAlert(topVC: self)
        } else {
            performSegue(withIdentifier: Constants.SegueKey.showSeeVCKey, sender: nil)
        }
    }
    
    @objc private func tapSetting(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Constants.SegueKey.showSettingVCKey, sender: nil)
    }
    
    private func checkSegueSetting() {
        guard let settingOfShowSeeVCIsOn = UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.SettingOfshowSeeVCKey),
              UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.sixTaskListKey) != nil
              else { return }
        if settingOfShowSeeVCIsOn as! Bool {
            performSegue(withIdentifier: Constants.SegueKey.showSeeVCKey, sender: nil)
        }
    }
    
    private func checkAutomaticalTransition() {
        // SeeViewControllerまたはInputViewControllerから遷移してきたときには、自動的に他のVCに遷移する。
        if UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.fromSeeVCKey) != nil {
            UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKey.fromSeeVCKey)
            performSegue(withIdentifier: Constants.SegueKey.showInputVCKey, sender: nil)
        }
        if UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.fromInputVCKey) != nil {
            UserDefaults.standard.removeObject(forKey: Constants.UserDefaultsKey.fromInputVCKey)
            performSegue(withIdentifier: Constants.SegueKey.showSeeVCKey, sender: nil)
        }
    }
    
    private func setUpView(){
        self.overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.20, green: 0.23, blue: 0.36, alpha: 1.0)
        startButton.layer.cornerRadius = 5
        self.navigationItem.backButtonTitle = "戻る"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "TOP"
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        settingButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(tapSetting(_:)))
        self.navigationItem.rightBarButtonItem = settingButton
        
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowRadius = 5
        startButton.layer.shadowOffset = .zero
        startButton.layer.shadowOpacity = 0.3
    }
    
}
