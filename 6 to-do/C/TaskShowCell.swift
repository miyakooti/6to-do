//
//  TaskShowCell.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/25.
//

import UIKit

class TaskShowCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    
    var isCompleted:Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
