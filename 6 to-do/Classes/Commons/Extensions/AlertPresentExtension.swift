//
//  AlertPresenter.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/04/19.
//

import Foundation
import UIKit
import GoogleMobileAds

extension UIViewController {
    
    func presentNewTaskAlert(topVC: TopViewController) {
        let alertController = UIAlertController(title: "まだタスクを登録していません。", message: "新たにタスクを登録しますか？", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
            topVC.performSegue(withIdentifier: .showInputVCKey, sender: nil)
        }
        let action2 = UIAlertAction(title: "いいえ", style: .cancel)
        alertController.addAction(action1)
        alertController.addAction(action2)
        // iPad対策--------------------------------------------------
        alertController.popoverPresentationController?.sourceView = topVC.view
        let screenSize = UIScreen.main.bounds
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        // end iPad対策--------------------------------------------------
        topVC.present(alertController, animated: true, completion: nil)
    }
    
    func presentSetTomorrowTaskAlert(numOfCompleted: Int, showListVC: ShowListViewController){
        let alertTitle:String
        let alertMessage:String
        if numOfCompleted == 6{
            alertTitle = "お疲れさまでした！"
            alertMessage = "明日のタスクを設定しますか？"

        } else {
            alertTitle = "今日のタスクを破棄しますか？"
            alertMessage = "キッパリ忘れるということも、アイビーリーメソッドは支持しています！"
        }
        
        let alertController = UIAlertController(title: alertTitle, message:alertMessage , preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
            showListVC.deleteAll()
        }
        let action2 = UIAlertAction(title: "いいえ", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        // iPad対策--------------------------------------------------
        alertController.popoverPresentationController?.sourceView = showListVC.view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
        // /iPad対策--------------------------------------------------
        
        showListVC.present(alertController, animated: true, completion: nil)
    }
    
}

final class AlertPresenter {
    
    static func presentNewTaskAlert(topVC: TopViewController) {
        let alertController = UIAlertController(title: "まだタスクを登録していません。", message: "新たにタスクを登録しますか？", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
            topVC.performSegue(withIdentifier: .showInputVCKey, sender: nil)
        }
        let action2 = UIAlertAction(title: "いいえ", style: .cancel)
        alertController.addAction(action1)
        alertController.addAction(action2)
        // iPad対策--------------------------------------------------
        alertController.popoverPresentationController?.sourceView = topVC.view
        let screenSize = UIScreen.main.bounds
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        // end iPad対策--------------------------------------------------
        topVC.present(alertController, animated: true, completion: nil)
    }
    
    static func presentSetTomorrowTaskAlert(numOfCompleted: Int, showListVC: ShowListViewController){
        let alertTitle:String
        let alertMessage:String
        if numOfCompleted == 6{
            alertTitle = "お疲れさまでした！"
            alertMessage = "明日のタスクを設定しますか？"

        } else {
            alertTitle = "今日のタスクを破棄しますか？"
            alertMessage = "キッパリ忘れるということも、アイビーリーメソッドは支持しています！"
        }
        
        let alertController = UIAlertController(title: alertTitle, message:alertMessage , preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
            showListVC.deleteAll()
        }
        let action2 = UIAlertAction(title: "いいえ", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        // iPad対策--------------------------------------------------
        alertController.popoverPresentationController?.sourceView = showListVC.view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect=CGRect(x:screenSize.size.width/2,y:screenSize.size.height,width:0,height:0)
        // /iPad対策--------------------------------------------------
        
        showListVC.present(alertController, animated: true, completion: nil)
    }
}
