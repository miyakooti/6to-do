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
                performSegue(withIdentifier: "showTwitter", sender: nil)
                return
            default:
                return
            }
        default:
            return
        }
    }
    
    @IBAction private func tapUISwitch(_ sender: Any) {
        if settingSwitch.isOn {
            UserDefaults.standard.setValue(true, forKey: "showSeeVCSetting")
        } else {
            UserDefaults.standard.setValue(false, forKey: "showSeeVCSetting")
        }
    }
    
    private func checkSwitchValue(){
        settingSwitch.isOn = UserDefaults.standard.bool(forKey: "showSeeVCSetting")
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
        // GADBannerViewのプロパティを設定
        bannerView.adUnitID = Constants.adUnitID
        bannerView.rootViewController = self

        // 広告読み込み
        bannerView.load(GADRequest())
    }
    
}
