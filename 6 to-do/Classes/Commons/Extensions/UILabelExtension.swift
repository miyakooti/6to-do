//
//  UILabelExtension.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/06/20.
//

import Foundation
import UIKit

extension UILabel {
    
    func convertCircle(width: Int) {
        self.layer.cornerRadius = CGFloat(width / 2)
        self.clipsToBounds = true
    }
    
}

