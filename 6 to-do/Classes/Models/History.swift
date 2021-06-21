//
//  History.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/06/20.
//

import Foundation

class History: Codable {
    
    var date: String = ""
    var body: String = ""
    
    init(date: String, text: String) {
        self.date = date
        self.body = text
    }
}
