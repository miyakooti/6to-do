//
//  TaskShowCell.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/25.
//

import UIKit

class TaskShowCell: UITableViewCell {
    
    static let identifier = TaskShowCell.className
    static func nib() -> UINib {
        return UINib(nibName: TaskShowCell.className, bundle: nil)
    }


    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var labelBackView: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    
    var isCompleted = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelBackView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepareCell(taskList: [Task], indexPath: IndexPath) {
                
        let taskText = taskList[indexPath.row].body
        let isCompleted = taskList[indexPath.row].isCompleted
        
        self.isCompleted = isCompleted
        
        let textForCell = String(indexPath.row + 1) + ". " + taskText
        self.taskLabel.text = textForCell
        
        if isCompleted == false {
            // 完了していないセル
            self.labelBackView.backgroundColor = ProjectColor.sixTodoPurple
            self.taskLabel.textColor = .white
            
        } else {
            // 完了したセル
    
            //セルを暗くする処理
            self.labelBackView.backgroundColor =  UIColor(red: 0.13, green: 0.15, blue: 0.24, alpha: 1.0)
            self.taskLabel.textColor = .darkGray
            
        }
    }
    
    func prepareCellForHistory(taskForHistory: String) {
        self.taskLabel.text = taskForHistory
    }
    
}
