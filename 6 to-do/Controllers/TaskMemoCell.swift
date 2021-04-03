//
//  TaskMemoCell.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/03/14.
//

import UIKit

class TaskMemoCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
