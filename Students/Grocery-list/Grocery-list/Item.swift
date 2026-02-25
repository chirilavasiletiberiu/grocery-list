//
//  Item.swift
//  Grocery-list
//
//  Created by tiberiu.chirila on 12.02.2026.
//

import Foundation
import SwiftData

@Model
class Item {
    var title: String
    var isCompleted: Bool
    
    init(title: String,
         isCompleted: Bool) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
