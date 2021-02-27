import UIKit

class TextInputViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var interactionButton: UIButton!
    @IBOutlet weak var interactionLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    var inputPhase = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        self.navigationItem.title = "明日のタスクを設定する"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TextInputCell", bundle: nil), forCellReuseIdentifier: "TextInputCell")
        tableView.separatorStyle = .none//罫線をなくす
        tableView.isScrollEnabled = false//スクロールさせない
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inputPhase = 1
    }
    
    // tableview---------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextInputCell", for: indexPath) as! TextInputCell
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
    
    // /tableview----------------------------------------------------------
    
    @IBAction func tapNext(_ sender: Any) {
        // 一部赤にする処理があるため随時初期化。
        interactionLabel.textColor = UIColor.black
        //ボタンのテキストを変更するメソッド
        checkButtonValue(phase: inputPhase)
        if inputPhase == 1{
            checkNullValue()//空き項目をゆる三蔵
            if isFilled{ //空き項目をゆるさんぞう
                tableView.setEditing(true, animated: true)
                interactionLabel.text = "重要な順に並べ替えてください。"
                inputPhase = inputPhase + 1
                return
            } else {
                interactionLabel.text = "※すべてのボックスを入力してください。"
                interactionLabel.textColor = UIColor.red
                return
            }
        }
        
        if inputPhase == 2{
            saveTasksFromTextField()
            tableView.setEditing(false, animated: true)
            interactionLabel.text = "６つのタスクが完成しました！"
            inputPhase = inputPhase + 1
            self.navigationItem.hidesBackButton = true
            saveTasksFromTextField()
            return
        }
        
        if inputPhase == 3{
            UserDefaults.standard.setValue("今日のタスクの設定が完了", forKey: "fromInputVC")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //ここおれの天才ポイント
    func saveTasksFromTextField(){
        //初期化
        var sixTaskList:[String] = []
        let isCompletedList = [Bool](repeating: false, count: 6)
        
        for i in 0...5{
            //これによって、intをIndexPath型に変換しています。
            let indexPath = IndexPath(row: i, section: 0)
            //そのIndexPathとcellForRowの処理をループさせることによって、カスタムセルの中の要素の値を取得できるようにしています。まじで天才ですね。
            let cell = tableView.cellForRow(at: indexPath) as! TextInputCell
            sixTaskList.append(cell.textField.text!)
        }
        UserDefaults.standard.setValue(sixTaskList, forKey: "sixTaskList")
        UserDefaults.standard.setValue(isCompletedList, forKey: "isCompletedList")
    }
    
    var isFilled = true
    func checkNullValue() {
        isFilled = true
        for i in 0...5{
            let indexPath = IndexPath(row: i, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! TextInputCell
            if cell.textField.text! == "" {
                isFilled = false
            }
        }
    }

    //ボタンのテキストを随時変更するためのメソッド
    func checkButtonValue(phase:Int){
            switch phase {
            case 1:
                nextButton.setTitle("これで確定", for: .normal)
            case 2:
                nextButton.setTitle("さっそくタスクを見る", for: .normal)
            default:
                print("checkButtonValueで不具合発生。")
            }
        }
}
