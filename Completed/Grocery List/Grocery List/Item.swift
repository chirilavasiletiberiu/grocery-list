//
//  CREDO ACADEMY ♥ DESIGN AND CODE
//  SwiftUI • SwiftData • Apple Intelligence • UI/UX Design • Apple AR
//  https://credo.academy
//  Created by Robert Petras
//

import Foundation
import SwiftData

@Model
class Item {
  var title: String
  var isCompleted: Bool
  
  init(title: String, isCompleted: Bool) {
    self.title = title
    self.isCompleted = isCompleted
  }
}
