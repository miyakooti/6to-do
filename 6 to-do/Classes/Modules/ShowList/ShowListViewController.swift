import UIKit
import GoogleMobileAds

final class ShowListViewController: UIViewController {
    
    private var garbageButton: UIBarButtonItem!
    private var sumOfCompletion = 0
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var topLabel: UILabel!
    
    private let sixTaskList = UserDefaults.standard.object(forKey: .sixTaskListKey) as! [String]
    private var isCompletedList = UserDefaults.standard.object(forKey: .isCompletedListKey) as! [Bool]
    private var numOfCompleted:Int?
    private let encourageMessageList = Constants.encourageMessageList

    @IBOutlet private weak var CompleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: .sumOfCompletionKey)
        setUpView()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)
    }
    
    @IBAction private func tapComplete(_ sender: Any) {
        if numOfCompleted == 6 { //終わってるときは終了ボタンとして挙動する。
            AlertPresenter.presentSetTomorrowTaskAlert(numOfCompleted: numOfCompleted!, showListVC: self)
        } else { //終わってないときは一つずつ完了させていくボタンとして挙動する。
            for i in 0...5{
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! TaskShowCell
                if cell.isCompleted == false { //　一番上のタスクを完了にする。
                    cell.isCompleted = true
                    
                    sumOfCompletion = sumOfCompletion + 1
                    UserDefaults.standard.setValue(sumOfCompletion, forKey: .sumOfCompletionKey)
                    
                    isCompletedList[indexPath.row] = true
                    UserDefaults.standard.setValue(isCompletedList, forKey: .isCompletedListKey)
                    UserDefaults.standard.synchronize()
                    
                    tableView.reloadData()
                    topLabel.text = encourageMessageList.randomElement()
                    return
                }
            }
        }
    }
    
    @objc private func tapGarbage(_ sender: UIBarButtonItem) {
        guard let num = numOfCompleted else { return }
        AlertPresenter.presentSetTomorrowTaskAlert(numOfCompleted: num, showListVC: self)
    }
    
    private func checkButtonValue(){

        if numOfCompleted == 6 {
            changeButtonValue()
            topLabel.text = "すべて完了しました！お疲れさまでした！"
        } else {
            CompleteButton.setTitle(String(numOfCompleted!+1)+"番のタスクを完了する", for: .normal)
        }
    }
    
    internal func deleteAll(){
        UserDefaults.standard.removeObject(forKey: .sixTaskListKey)
        UserDefaults.standard.removeObject(forKey: .isCompletedListKey)
        UserDefaults.standard.setValue("明日のタスクを設定中", forKey: .fromSeeVCKey)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpView() {
        self.overrideUserInterfaceStyle = .light
        self.navigationItem.title = VCType.showList.navigationTitle
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TaskShowCell", bundle: nil), forCellReuseIdentifier: "TaskShowCell")
        tableView.separatorStyle = .none//罫線をなくす
        tableView.isScrollEnabled = false//スクロールさせない
        
        CompleteButton.layer.cornerRadius = 5
        
        garbageButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapGarbage(_:)))
        self.navigationItem.rightBarButtonItem = garbageButton
        
        CompleteButton.layer.shadowColor = UIColor.black.cgColor
        CompleteButton.layer.shadowRadius = 5
        CompleteButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        CompleteButton.layer.shadowOpacity = 0.6
    }
    
    private func changeButtonValue() {
        CompleteButton.setTitle("明日のタスクを設定する", for: .normal)
        CompleteButton.layer.shadowColor = UIColor.yellow.cgColor
        CompleteButton.layer.shadowRadius = 5
        CompleteButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        CompleteButton.layer.shadowOpacity = 1
    }
}




extension ShowListViewController: UITableViewDelegate, UITableViewDataSource{
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskShowCell", for: indexPath) as! TaskShowCell
        isCompletedList = UserDefaults.standard.object(forKey: .isCompletedListKey) as! [Bool]
        cell.isCompleted = isCompletedList[indexPath.row]
        
        let textForCell = String(indexPath.row + 1)+". "+sixTaskList[indexPath.row]
        numOfCompleted = isCompletedList.filter({$0 == true}).count
        checkButtonValue()
        
        if cell.isCompleted == false {
            // 完了したセルは
            cell.taskLabel.text = textForCell
        } else {
            // 完了していないセル
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
    
}
