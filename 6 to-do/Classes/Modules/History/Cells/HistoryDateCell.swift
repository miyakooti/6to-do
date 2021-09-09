//
//  HistoryDateCell.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/06/22.
//

import UIKit

class HistoryDateCell: UITableViewCell {
    
    static let identifier = HistoryDateCell.className
    static func nib() -> UINib {
        return UINib(nibName: HistoryDateCell.className, bundle: nil)
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var labelText: String = "" {
        didSet {
            dateLabel.text = labelText
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.textColor = ProjectColor.sixTodoTextGray
        
        
        print(UIView.className)
        // "UIView"が出力される
        
        let myLabel = UILabel()
        print(myLabel.className)
        // "UILabel"が出力される
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    
}

