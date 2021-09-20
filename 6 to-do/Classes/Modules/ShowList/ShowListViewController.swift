import UIKit
import GoogleMobileAds

final class ShowListViewController: UIViewController {
    
    private var garbageButton: UIBarButtonItem!
    private var sumOfCompletion = 0
    private var numOfCompleted = 0
    private var taskHistories: [History] = []
    private var tasks: [Task] = []
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var topMessageLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet private weak var CompleteButton: UIButton!
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: .sumOfCompletionKey)
        taskHistories = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)
        setUpView()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)
        
        testButton.addTarget(self, action: #selector(self.tapTest(_:)), for: .touchUpInside)

    }
    
    @IBAction private func tapComplete(_ sender: Any) {
        if numOfCompleted == 6 { //終わってるときは終了ボタンとして挙動する。
            AlertPresenter.presentSetTomorrowTaskAlert(numOfCompleted: numOfCompleted, showListVC: self)
        } else { //終わってないときは一つずつ完了させていくボタンとして挙動する。
            numOfCompleted = 0 // 合計値ば随時reload dataで計算するので、毎回初期化していい
            for i in 0...5 {
                
                let indexPath = IndexPath(row: i, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! TaskShowCell
                if cell.isCompleted == false { //　一番上のタスクを完了にする
                    // ここの中は実質一度しか実行されません。
                    tasks[indexPath.row].isCompleted = true // table自体に書き込むことはしないで、プログラム上の表面上のデータのみの変更。
                    
                    sumOfCompletion = sumOfCompletion + 1 // 一生記録する
                    UserDefaults.standard.setValue(sumOfCompletion, forKey: .sumOfCompletionKey)
                    
                    cell.isCompleted = true
                    JsonEncoder.saveItemsToUserDefaults(list: tasks, key: .sixTaskListKey)

                    let text = tasks[indexPath.row].body
                    saveToHistory(text: text)

                    tableView.reloadData()
                    topMessageLabel.text = Constants.encourageMessageList.randomElement()
                    return
                }
            }
        }
    }
    
    @objc private func tapTest(_ sender: UIButton) {
        let unfinishedTasks = tasks.filter({$0.isCompleted == false})
        for task in unfinishedTasks {
            print(task.body)
        }
        let vc = TomorrowModalViewController.instantiate()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc private func tapGarbage(_ sender: UIBarButtonItem) {
        AlertPresenter.presentSetTomorrowTaskAlert(numOfCompleted: numOfCompleted, showListVC: self)
    }
    
    private func checkButtonValue(){

        if numOfCompleted == 6 {
            changeButtonValue()
            topMessageLabel.text = "すべて完了しました！お疲れさまでした！"
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
    
    private func saveToHistory(text: String) {
        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let nowString = dateFormatter.string(from: now as Date)
        let todayString = nowString.prefix(10)
        
        let history = History(date: String(todayString), text: text)
        
        taskHistories.insert(history, at: 0)
        
        if taskHistories.count > 300 {
            taskHistories.removeLast()
        }
        JsonEncoder.saveItemsToUserDefaults(list: taskHistories, key: .HistoryKey)
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
        print("tableview delegate method")
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
        
        tasks = JsonEncoder.readItemsFromUserUserDefault(key: .sixTaskListKey)
        cell.prepareCell(taskList: tasks, indexPath: indexPath)
        
        if cell.isCompleted {
            numOfCompleted = numOfCompleted + 1
        }
        checkButtonValue()

        return cell
    }
    
}
