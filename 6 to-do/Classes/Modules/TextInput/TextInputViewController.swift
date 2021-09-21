import UIKit

final class TextInputViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var interactionButton: UIButton!
    @IBOutlet private weak var interactionLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    
    private var inheritedTasks: [Task] = []
    
    private var inputPhase = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        resetInputPhase()
        inheritedTasks = JsonEncoder.readItemsFromUserUserDefault(key: .unCompletedTasksKey)
    }

    @IBAction private func tapNext(_ sender: Any) {
        interactionLabel.textColor = UIColor.black
        checkButtonValue(phase: inputPhase)
        
        switch inputPhase {
        case 1:
            let isFilled = checkIsFilled()
            if isFilled {
                tableView.setEditing(true, animated: true)
                interactionLabel.text = "重要な順に並べ替えてください。"
                inputPhase = inputPhase + 1
                return
            } else {
                interactionLabel.text = "※すべてのボックスを入力してください。"
                interactionLabel.textColor = UIColor.red
                return
            }
        case 2:
            saveTasksFromTextField()
            tableView.setEditing(false, animated: true)
            interactionLabel.text = "６つのタスクが完成しました！"
            inputPhase = inputPhase + 1
            self.navigationItem.hidesBackButton = true
            saveTasksFromTextField()
            return
        case 3:
            UserDefaults.standard.setValue("今日のタスクの設定が完了", forKey: .fromInputVCKey)
            UserDefaults.standard.removeObject(forKey: .unCompletedTasksKey)
            self.navigationController?.popViewController(animated: true)
        default:
            print("tapNextがおかしいです")
            return
        }
        
    }
    
    private func saveTasksFromTextField(){
        //初期化
        var taskList: [Task] = []
        
        for i in 0...5{
            //これによって、intをIndexPath型に変換しています。
            let indexPath = IndexPath(row: i, section: 0)
            //そのIndexPathとcellForRowの処理をループさせることによって、カスタムセルの中の要素の値を取得できるようにしています。
            let cell = tableView.cellForRow(at: indexPath) as! TextInputCell
            
            guard let text = cell.textField.text else { return }
            let task = Task(body: text, isCompleted: false)
            taskList.append(task)
            
            JsonEncoder.saveItemsToUserDefaults(list: taskList, key: .sixTaskListKey)
        }

    }
    
    private func checkIsFilled() -> Bool {
        
        for i in 0...5{
            let indexPath = IndexPath(row: i, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! TextInputCell
            if cell.textField.text! == "" {
                return false
            }
        }
        
        return true
    }

    private func checkButtonValue(phase:Int) {
            switch phase {
            case 1:
                nextButton.setTitle("これで確定", for: .normal)
            case 2:
                nextButton.setTitle("さっそくタスクを見る", for: .normal)
            default:
                print("checkButtonValueで不具合発生。")
            }
        }
    
    private func setUpView() {
        self.overrideUserInterfaceStyle = .light
        self.navigationItem.title = VCType.textInput.navigationTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TextInputCell", bundle: nil), forCellReuseIdentifier: "TextInputCell")
        tableView.separatorStyle = .none//罫線をなくす
        tableView.isScrollEnabled = false//スクロールさせない
        
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowRadius = 5
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        nextButton.layer.shadowOpacity = 0.6
        
    }
    
    private func resetInputPhase() {
        inputPhase = 1
    }
}

extension TextInputViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
        if indexPath.row < self.inheritedTasks.count {
            cell.textField.text = self.inheritedTasks[indexPath.row].body
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    //　タップしたときにハイライトしない
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    //これは必須。消したらtableView編集できなくなる。
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    //編集モードにしたとき、
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .none
    }
    //編集モードにしたとき、左からインデントしない
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
      return false
    }
    
}
