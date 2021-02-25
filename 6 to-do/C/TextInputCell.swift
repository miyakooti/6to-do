//
//  TextInputCell.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/02/25.
//

import UIKit

class TextInputCell: UITableViewCell {

    @IBOutlet weak var navView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        navView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
