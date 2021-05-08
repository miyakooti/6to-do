//
//  SettingTableViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/26.
//

import UIKit
import StoreKit
import GoogleMobileAds

final class SettingTableViewController: UITableViewController {
    
    @IBOutlet private weak var bannerView: GADBannerView!
    
    @IBOutlet private var myTableView: UITableView!
    @IBOutlet private weak var settingSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)
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
            default:
                return
            }
        case 1:
            switch row {
            case 0:
                //アイビーリーメソッドとは？
                performSegue(withIdentifier: Constants.SegueKey.showWhatIsVCKey, sender: nil)
            case 1:
                //レビューを書く
                dispReview()
                return
            case 2:
                //開発者のtwitter
                performSegue(withIdentifier: Constants.SegueKey.showTwitterVCKey, sender: nil)
                return
            case 3:
                //これまでに完了したtodoの数
                performSegue(withIdentifier: Constants.SegueKey.showSumVCKey, sender: nil)
                return
            default:
                return
            }
        default:
            return
        }
    }
    
    @IBAction private func tapUISwitch(_ sender: Any) {
        UserDefaults.standard.setValue(settingSwitch.isOn, forKey: Constants.UserDefaultsKey.SettingOfshowSeeVCKey)
    }
    
    private func checkSwitchValue(){
        settingSwitch.isOn = UserDefaults.standard.bool(forKey: Constants.UserDefaultsKey.SettingOfshowSeeVCKey)
    }
    
    private func dispReview(){
        if #available(iOS 10.3, *){
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            print("iOS 10.3未満です")
        }
    }
    
    private func setUpView() {
        self.navigationItem.title = "設定"
        self.overrideUserInterfaceStyle = .light
        checkSwitchValue()
        if let indexPathForSelectedRow = myTableView.indexPathForSelectedRow { //ハイライト解除
            myTableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }

    }
    
}
