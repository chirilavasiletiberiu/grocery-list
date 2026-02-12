//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import SwiftUI
import SwiftData

@main
struct Grocery_ListApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
        .modelContainer(for: Item.self)
    }
  }
}
