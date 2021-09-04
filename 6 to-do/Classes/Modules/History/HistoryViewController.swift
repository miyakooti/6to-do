//
//  HistoryViewController.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/06/20.
//

import UIKit

final class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var animationLabel: CountAnimateLabel!
    private var sumOfCompletion = 0
    private var historyListForTableView: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        sumOfCompletion = UserDefaults.standard.integer(forKey: .sumOfCompletionKey)
        setUpViews()
        
        tableView.register(TaskShowCell.nib(), forCellReuseIdentifier: TaskShowCell.identifier)
        tableView.register(HistoryDateCell.nib(), forCellReuseIdentifier: HistoryDateCell.identifier)
        
        prepareHistoryListForTableView()

    }

    private func setUpViews(){
        self.navigationItem.title = VCType.showSum.navigationTitle
        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = ProjectColor.sixTodoGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        prepareAnimationLabel()
    }
    
    private func prepareAnimationLabel() {
        
        animationLabel = CountAnimateLabel()
        let margin = 30
        let labelWidth = 170
        let labelHeight = 170
        animationLabel.frame = CGRect(x: Int(self.view.bounds.width) - labelWidth - margin, y: Int(self.view.bounds.height) - labelHeight - margin, width: labelWidth, height: labelHeight)
        animationLabel.textAlignment = .center
        animationLabel.backgroundColor = ProjectColor.sixTodoLightPurple
        animationLabel.textColor = .black
        animationLabel.font = .boldSystemFont(ofSize: 70)
        animationLabel.textAlignment = .center
        animationLabel.adjustsFontSizeToFitWidth = true
        animationLabel.textColor = .white
        
        animationLabel.shadowOffset = CGSize(width: 2, height: 2)
        animationLabel.shadowColor = .darkGray
  
        animationLabel.convertCircle(width: labelWidth)
        
        animationLabel.layer.borderWidth = 2
        animationLabel.layer.borderColor = UIColor.lightGray.cgColor
        
//        animationLabel.layer.shadowColor = UIColor.black.cgColor
//        animationLabel.layer.shadowRadius = 170
//        animationLabel.layer.shadowOffset = CGSize(width: 170, height: 170)
//        animationLabel.layer.shadowOpacity = 0
        
        
        self.view.addSubview(animationLabel)
        animationLabel.animate(from: 0, to: sumOfCompletion, duration: 1.3)
    }
    
//   手続き
    private func prepareHistoryListForTableView() {
        
        historyListForTableView.removeAll()
        
        let historyList: [History] = JsonEncoder.readItemsFromUserUserDefault(key: .HistoryKey)
        guard historyList.count != 0 else {
            // まだhistoryListがからです。
            return
        }
        
        var tempDate = ""
        for history in historyList {

            if history.date != tempDate {
                historyListForTableView.append(history.date + "thisisdate")
                tempDate = history.date
            }
            historyListForTableView.append(history.body)
        }
        print(historyListForTableView)
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return historyListForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let date = historyListForTableView[indexPath.row].prefix(10)
        let tail = historyListForTableView[indexPath.row].suffix(10)
        
        if tail == "thisisdate" {
            let cell = tableView.dequeueReusableCell(withIdentifier: HistoryDateCell.identifier) as! HistoryDateCell
            cell.labelText = String(date)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TaskShowCell.identifier) as! TaskShowCell
            cell.prepareCellForHistory(taskForHistory: historyListForTableView[indexPath.row])
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tail = historyListForTableView[indexPath.row].suffix(10)
        if tail == "thisisdate" {
            return 45
        } else {
            return 45
        }
    
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}
