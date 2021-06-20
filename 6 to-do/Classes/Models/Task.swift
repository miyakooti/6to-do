//
//  Task.swift
//  6 to-do
//
//  Created by Arai Kousuke on 2021/06/20.
//

import Foundation

class Task: Codable {
    var body: String
    var isCompleted: Bool
    
    init(body: String, isCompleted: Bool) {
        self.body = body
        self.isCompleted = isCompleted
    }
}
