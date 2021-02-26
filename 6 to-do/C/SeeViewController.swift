//
//  SeeViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/25.
//

import UIKit

class SeeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topLabel: UILabel!
    let sixTaskList = UserDefaults.standard.object(forKey: "sixTaskList") as! [String]

    var isCompletedList = UserDefaults.standard.object(forKey: "isCompletedList") as! [Bool]
    
    var numOfCompleted:Int?

    @IBOutlet weak var CompleteButton: UIButton!
    @IBOutlet weak var giveUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskShowCell", bundle: nil), forCellReuseIdentifier: "TaskShowCell")
        tableView.separatorStyle = .none//罫線をなくす
        tableView.isScrollEnabled = false//スクロールさせない
        
        CompleteButton.layer.cornerRadius = 5
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false //ハイライトしない
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //　カスタムセル取り出す
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskShowCell", for: indexPath) as! TaskShowCell
        //　userdefaultsの内容を取り出す
        isCompletedList = UserDefaults.standard.object(forKey: "isCompletedList") as! [Bool]
        //　userdefaultsの内容をセルの変数に格納する。
        cell.isCompleted = isCompletedList[indexPath.row]
        
        let textForCell = String(indexPath.row + 1)+". "+sixTaskList[indexPath.row]
        numOfCompleted = isCompletedList.filter({$0 == true}).count
        print(isCompletedList.filter({$0 == true}).count)
        checkButtonValue()
        
        //　セルが完了したか完了していないかで分岐。
        if cell.isCompleted == false {
            cell.taskLabel.text = textForCell
        } else {
            //棒線処理
            let atr =  NSMutableAttributedString(string: textForCell)
            atr.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, atr.length))
            cell.taskLabel.attributedText = atr
            
            //セルを暗くする処理
            cell.backView.backgroundColor =  UIColor(red: 0.13, green: 0.15, blue: 0.24, alpha: 1.0)
            cell.taskLabel.textColor = .darkGray
        }
        return cell
    }
    
    
    @IBAction func tapComplete(_ sender: Any) {
        
        if numOfCompleted == 6 { //終わってるときは終了ボタンとして挙動する。
            trySetTomorrowTask()
        } else { //終わってないときは一つずつ完了させていくボタンとして挙動する。
            for i in 0...5{
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! TaskShowCell
                
                //　一番上のタスクを完了にする。
                if cell.isCompleted == false {
                    cell.isCompleted = true
                    // userdefaultsの内容も変えないとね
                    isCompletedList[indexPath.row] = true
                    UserDefaults.standard.setValue(isCompletedList, forKey: "isCompletedList") //trueを登録していく。
                    // セルの内容変えたので、リロードして最新にする。
                    tableView.reloadData()
                    return
                }
            }
        }
    }
    
    @IBAction func tapSetTomorrow(_ sender: Any) {
        trySetTomorrowTask()
    }
    
    
    func checkButtonValue(){

        if numOfCompleted == 6 {
            CompleteButton.setTitle("明日のタスクを設定する", for: .normal)
            topLabel.text = "すべて完了しました！お疲れさまでした！"
            giveUpButton.isEnabled = false
            
            CompleteButton.layer.shadowColor = UIColor.yellow.cgColor
            CompleteButton.layer.shadowRadius = 5
            CompleteButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            CompleteButton.layer.shadowOpacity = 1
            
        } else {
            CompleteButton.setTitle(String(numOfCompleted!+1)+"番のタスクを完了する", for: .normal)
        }
    }
    
    func resetAll(){
        UserDefaults.standard.removeObject(forKey: "sixTaskList")
        UserDefaults.standard.removeObject(forKey: "isCompletedList")
        UserDefaults.standard.setValue("明日のタスクを設定中", forKey: "fromSeeVC")
        self.navigationController?.popViewController(animated: true)
    }
    
    func trySetTomorrowTask(){
        //完了しているときとしていないときで文言を変えたいので分岐。これによりアラートアクションは共通化できる。
        let alertTitle:String
        let alertMessage:String
        if numOfCompleted == 6{
            alertTitle = "お疲れさまでした！"
            alertMessage = "明日のタスクを設定しますか？"

        } else {
            alertTitle = "明日のタスクを設定しますか？"
            alertMessage = "完了していないタスクがありますが、キッパリ忘れるということも、アイビーリーメソッドでは重要です！"
        }
        
        let alertController = UIAlertController(title: alertTitle, message:alertMessage , preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "はい", style: .default) { (alert) in
            self.resetAll()
        }
        let action2 = UIAlertAction(title: "いいえ", style: .cancel)
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.present(alertController, animated: true, completion: nil)
    }

}
