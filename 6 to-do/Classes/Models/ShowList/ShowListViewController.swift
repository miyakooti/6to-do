import UIKit
import GoogleMobileAds

final class ShowListViewController: UIViewController {
    
    private var garbageButton: UIBarButtonItem!
    private var sumOfCompletion = 0
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var topLabel: UILabel!
    
    private var numOfCompleted = 0
    private var historyList: [History] = []
    private var taskList: [Task] = []
    private let encourageMessageList = Constants.encourageMessageList

    @IBOutlet private weak var CompleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: .sumOfCompletionKey)
        historyList = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)
        setUpView()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)

    }
    
    @IBAction private func tapComplete(_ sender: Any) {
        print(numOfCompleted)
        if numOfCompleted == 6 { //終わってるときは終了ボタンとして挙動する。
            AlertPresenter.presentSetTomorrowTaskAlert(numOfCompleted: numOfCompleted, showListVC: self)
        } else { //終わってないときは一つずつ完了させていくボタンとして挙動する。
            numOfCompleted = 0 // 合計値ば随時reload dataで計算するので、毎回初期化していい
            for i in 0...5{
                // ここの中は一度しか実行されません
                
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! TaskShowCell
                if cell.isCompleted == false { //　一番上のタスクを完了にする。
                    taskList[indexPath.row].isCompleted = true // table自体に書き込むことはしないで、プログラム上の表面上のデータのみの変更。
                    
                    sumOfCompletion = sumOfCompletion + 1 // 一生記録する
                    UserDefaults.standard.setValue(sumOfCompletion, forKey: .sumOfCompletionKey)
                    
                    cell.isCompleted = true
                    JsonEncoder.saveItemsToUserDefaults(list: taskList, key: .sixTaskListKey)
                    
                    
                    
                    let now = NSDate()
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                    let nowString = dateFormatter.string(from: now as Date)
                    let todayString = nowString.prefix(10)
                    
                    let history = History(date: String(todayString), text: taskList[indexPath.row].body)
                    
                    historyList.append(history)
                    
                    JsonEncoder.saveItemsToUserDefaults(list: historyList, key: .HistoryKey)
                    
                    let test: [History] = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)

                    
                    

                    tableView.reloadData()
                    topLabel.text = encourageMessageList.randomElement()
                    return
                }
            }
        }
    }
    
    @objc private func tapGarbage(_ sender: UIBarButtonItem) {
        let num = numOfCompleted
        AlertPresenter.presentSetTomorrowTaskAlert(numOfCompleted: num, showListVC: self)
    }
    
    private func checkButtonValue(){

        if numOfCompleted == 6 {
            changeButtonValue()
            topLabel.text = "すべて完了しました！お疲れさまでした！"
        } else {
            CompleteButton.setTitle(String(numOfCompleted + 1)+"番のタスクを完了する", for: .normal)
        }
    }
    
    internal func deleteAll(){
        UserDefaults.standard.removeObject(forKey: .sixTaskListKey)
        UserDefaults.standard.setValue("明日のタスクを設定中", forKey: .fromSeeVCKey)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeButtonValue() {
        CompleteButton.setTitle("明日のタスクを設定する", for: .normal)
        CompleteButton.layer.shadowColor = UIColor.yellow.cgColor
        CompleteButton.layer.shadowRadius = 5
        CompleteButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        CompleteButton.layer.shadowOpacity = 1
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
        
        taskList = JsonEncoder.readItemsFromUserUserDefault(key: .sixTaskListKey)
        cell.prepareCell(taskList: taskList, indexPath: indexPath)
        
        if cell.isCompleted {
            numOfCompleted = numOfCompleted + 1
        }
        checkButtonValue()

        return cell
    }
    
}
