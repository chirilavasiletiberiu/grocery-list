//
//  ButtonTip.swift
//  Grocery-list
//
//  Created by tiberiu.chirila on 15.02.2026.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    var title: Text = Text("Essential Foods")
    var message: Text? = Text("Add some everyday items for the shopping list.")
    var image: Image? = Image(systemName: "info.circle")
}
