//
//  CheckBox.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/21.
//

import Foundation
import UIKit

class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "check-on")! as UIImage
    let uncheckedImage = UIImage(named: "check-off")! as UIImage

    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }

    override func awakeFromNib() {
        let state = UserDefaults.standard.bool(forKey: .checkBoxStateKey)
        self.isChecked = state
    }
    
    func reverseState() {
        switch isChecked {
        case true:
            self.isChecked = false
        case false:
            self.isChecked = true
        }
    }
}
