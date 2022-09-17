import Foundation
import SwiftUI

struct AppAppearance {
  struct Colors {
    /// White equivalent
    static let color_ffffff = Color("color_ffffff")
    /// Black equivalent
    static let color_313031 = Color("color_313031")
  }
  
  struct Fonts {
    static let regular_16 = Font.system(
      size: 16,
      weight: .regular,
      design: .default
    )
    static let semibold_35 = Font.system(
      size: 35,
      weight: .semibold,
      design: .default
    )
  }
  
  struct Spacing {
    /// 5 pt
    static let small: CGFloat = 5
  }
}
