//
//  ViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/24.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.20, green: 0.23, blue: 0.36, alpha: 1.0)
        startButton.layer.cornerRadius = 5
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
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "show", sender: nil)
        }
    }
    
    @IBAction func tapDelete(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "sixTaskList")
        UserDefaults.standard.removeObject(forKey: "isCompletedList")
    }
}

