import UIKit

class TextInputViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var interactionButton: UIButton!
    @IBOutlet weak var interactionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false //ハイライトしない
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    //この辺いらんかも
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      // 移動処理
//      let element = tableDataList[sourceIndexPath.row]
//      tableDataList.remove(at: sourceIndexPath.row)
//      tableDataList.insert(element, at: destinationIndexPath.row)
    }
    
    //編集モードにしたとき、
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
      return .none
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
      return false
    }
    
    // tableview---------------------------------------------------------

    
    
//    キーボード関連
    
    
    @IBAction func tapNext(_ sender: Any) {
    
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
    
    var inputPhase = 1
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

    
}
