//
//  AlertPresenter.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/04/19.
//

import Foundation
import UIKit

class AlertPresenter {
    static func presentNewTaskAlert(viewController: UIViewController) {
        let alertController = UIAlertController(title: "まだタスクを登録していません。", message: "新たにタスクを登録しますか？", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
            viewController.performSegue(withIdentifier: Constants.UserDefaultsKey.showInputVCKey, sender: nil)
        }
        let action2 = UIAlertAction(title: "いいえ", style: .cancel)
        alertController.addAction(action1)
        alertController.addAction(action2)
        // iPad対策--------------------------------------------------
        alertController.popoverPresentationController?.sourceView = viewController.view
        let screenSize = UIScreen.main.bounds
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width/2, y: screenSize.size.height, width: 0, height: 0)
        // end iPad対策--------------------------------------------------
        viewController.present(alertController, animated: true, completion: nil)
    }

}
