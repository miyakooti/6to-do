//
//  NSObject.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/09/10.
//

import Foundation

extension NSObject {
        
    // from class
    class var className: String {
        return String(describing: self)
    }
    
    // from instance
    var className: String {
        return String(describing: type(of: self))
    }
    
}
