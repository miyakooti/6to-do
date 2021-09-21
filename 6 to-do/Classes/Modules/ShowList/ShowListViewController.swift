import UIKit
import GoogleMobileAds

final class ShowListViewController: UIViewController {
    
    private var garbageButton: UIBarButtonItem!
    private var sumOfCompletion = 0
    private var numOfCompleted = 0
    private var taskHistories: [History] = []
    private var tasks: [Task] = []
    var inheritUnCompletedTasks: Bool = false
    
    @IBOutlet private weak var bannerView: GADBannerView!
    @IBOutlet private weak var topMessageLabel: UILabel!
    @IBOutlet private weak var CompleteButton: UIButton!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let shadeView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))

    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: .sumOfCompletionKey)
        taskHistories = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)
        setUpView()
        bannerView.setUpBanner(bannerView: bannerView, viewController: self)
        NotificationCenter.default.addObserver(self, selector: #selector(removeShadeView), name: .tomorrowModalDidClosed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToSetTomorrowTask), name: .tomorrowModalYes, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeShadeView), name: .modalClosed, object: nil)
    }
    
    @objc func removeShadeView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.shadeView.alpha = 0
        }) { (done) in
            if done {
                self.shadeView.removeFromSuperview()
            }
        }
    }
    
    @IBAction private func tapComplete(_ sender: Any) {
        if numOfCompleted == 6 { //終わってるときは終了ボタンとして挙動する。
            
            let vc = SelectModalViewController.instantiate()
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            vc.titleText = "お疲れさまでした！\n明日のタスクを設定しますか？"
            self.present(vc, animated: true, completion: nil)
            
            shadeView.backgroundColor = .black
            shadeView.alpha = 0
            self.view.addSubview(shadeView)
            UIView.animate(withDuration: 0.2) {
                self.shadeView.alpha = 0.3
            }
            
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
    
    @objc private func tapGarbage(_ sender: UIBarButtonItem) {
        
        let vc = TomorrowModalViewController.instantiate()
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
        
        shadeView.backgroundColor = .black
        shadeView.alpha = 0
        self.view.addSubview(shadeView)
        UIView.animate(withDuration: 0.2) {
            self.shadeView.alpha = 0.3
        }
    }
    
    private func checkButtonValue(){
        if numOfCompleted == 6 {
            changeButtonValue()
            topMessageLabel.text = "すべて完了しました！お疲れさまでした！"
        } else {
            CompleteButton.setTitle(String(numOfCompleted + 1)+"番のタスクを完了する", for: .normal)
        }
    }
    
    @objc internal func goToSetTomorrowTask(){
        UserDefaults.standard.removeObject(forKey: .sixTaskListKey)
        UserDefaults.standard.setValue("明日のタスクを設定中", forKey: .fromSeeVCKey) // ここはnotification centerでやるべき
        let unCompletedTasks = tasks.filter({$0.isCompleted == false})
        if inheritUnCompletedTasks {
            JsonEncoder.saveItemsToUserDefaults(list: unCompletedTasks, key: .unCompletedTasksKey)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func changeButtonValue() {
        CompleteButton.setTitle("明日のタスクを設定する", for: .normal)
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
        CompleteButton.layer.shadowRadius = CompleteButton.layer.bounds.width / 2
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
        
        tasks = JsonEncoder.readItemsFromUserUserDefault(key: .sixTaskListKey)
        cell.prepareCell(taskList: tasks, indexPath: indexPath)
        
        if cell.isCompleted {
            numOfCompleted = numOfCompleted + 1
        }
        checkButtonValue()

        return cell
    }
    
}

extension ShowListViewController: catchDataFromModal {
    func catchData(isChecked: Bool) {
        self.inheritUnCompletedTasks = isChecked
    }
}

extension ShowListViewController: CatchModalActionDelegate {
    func catchModalAction() {
        self.goToSetTomorrowTask()
    }
}
