import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    var settingButton:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.20, green: 0.23, blue: 0.36, alpha: 1.0)
        startButton.layer.cornerRadius = 5
        self.navigationItem.backButtonTitle = "戻る"
        //　戻るとかのボタン。rightとleftのやつ
        self.navigationController?.navigationBar.tintColor = .white
        //　タイトル設定
        self.navigationItem.title = "TOP"
        // navBar背景色
        self.navigationController!.navigationBar.titleTextAttributes = [
        .foregroundColor: UIColor.white
        ]
        
        settingButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapSetting(_:)))
        self.navigationItem.rightBarButtonItem = settingButton
        
        checkSegueSetting()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // SeeViewControllerまたはInputViewControllerから遷移してきたときには、自動的に他のVCに遷移する。
        if UserDefaults.standard.object(forKey: "fromSeeVC") != nil {
            UserDefaults.standard.removeObject(forKey: "fromSeeVC")
            performSegue(withIdentifier: "input", sender: nil)
        }
        if UserDefaults.standard.object(forKey: "fromInputVC") != nil {
            UserDefaults.standard.removeObject(forKey: "fromInputVC")
            performSegue(withIdentifier: "show", sender: nil)
        }
        
    }
    
    

    @IBAction func tapStart(_ sender: Any) {
        if UserDefaults.standard.object(forKey: "sixTaskList") == nil{
            let alertController = UIAlertController(title: "まだタスクを登録していません。", message: "新たにタスクを登録しますか？", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
                self.performSegue(withIdentifier: "input", sender: nil)
            }
            let action2 = UIAlertAction(title: "いいえ", style: .cancel)
            
            alertController.addAction(action1)
            alertController.addAction(action2)
            
            // iPad対策--------------------------------------------------
            alertController.popoverPresentationController?.sourceView=self.view
            let screenSize = UIScreen.main.bounds
            // ここで表示位置を調整
            // xは画面中央、yは画面下部になる様に指定
            alertController.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
            // /iPad対策--------------------------------------------------
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "show", sender: nil)
        }
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sixTaskList")
        UserDefaults.standard.removeObject(forKey: "isCompletedList")
        UserDefaults.standard.removeObject(forKey: "goToShowSetting")

    }
    
    @objc func tapSetting(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "setting", sender: nil)
    }
    
    func checkSegueSetting() {
        if UserDefaults.standard.object(forKey: "goToShowSetting") != nil && UserDefaults.standard.object(forKey: "sixTaskList") != nil {
            let goToShowSetting = UserDefaults.standard.object(forKey: "goToShowSetting") as! Bool
            switch goToShowSetting {
            case true:
                performSegue(withIdentifier: "show", sender: nil)
            case false:
                return
            }
        }
    }
}

