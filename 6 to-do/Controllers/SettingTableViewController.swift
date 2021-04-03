//
//  SettingTableViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/26.
//

import UIKit
import StoreKit
import GoogleMobileAds

class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row

        // switchを２個使って、セクションとrowの場合分け。
        switch section {
        case 0:
            switch row {
            case 0:
                //　アプリ起動時、自動でタスク一覧を表示
                return
            case 1:
                //to-doメモ
                performSegue(withIdentifier: "goToMemo", sender: nil)
            default:
                return
            }
        case 1:
            switch row {
            case 0:
                //アイビーリーメソッドとは？
                performSegue(withIdentifier: "whatIs", sender: nil)
            case 1:
                //レビューを書く
                dispReview()
                return
            case 2:
                //開発者のtwitter
                performSegue(withIdentifier: "twitter", sender: nil)
                return
            default:
                return
            }
        default:
            return
        }
    }
    
    @IBAction func tapUISwitch(_ sender: Any) {
        if settingSwitch.isOn {
            defaults.setValue(true, forKey: "showSeeVCSetting")
        } else {
            defaults.setValue(false, forKey: "showSeeVCSetting")
        }
    }
    
    func checkSwitchValue(){
        //よく考えたら一行でいい、、
        settingSwitch.isOn = defaults.bool(forKey: "showSeeVCSetting")
    }
    
    // レビューページへ遷移
    func dispReview(){
        if #available(iOS 10.3, *){
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
    func setUpView() {
        self.navigationItem.title = "設定"
        self.overrideUserInterfaceStyle = .light
        checkSwitchValue()
        
        if let indexPathForSelectedRow = myTableView.indexPathForSelectedRow { //ハイライト解除
            myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
        // GADBannerViewのプロパティを設定
        bannerView.adUnitID = Constants.adUnitID
        bannerView.rootViewController = self

        // 広告読み込み
        bannerView.load(GADRequest())
    }
    
}
