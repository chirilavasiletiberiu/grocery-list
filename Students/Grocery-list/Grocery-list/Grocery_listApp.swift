//
//  Grocery_listApp.swift
//  Grocery-list
//
//  Created by tiberiu.chirila on 12.02.2026.
//

import SwiftUI
import SwiftData

@main
struct Grocery_listApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
