import Foundation
import SwiftUI

struct AppAppearance {
  struct Colors {
    /// White equivalent
    static let color_ffffff = Color("color_ffffff")
    /// Black equivalent
    static let color_313031 = Color("color_313031")
    /// Teal
    static let color_9a8d9f = Color("color_9a8d9f")
  }
  
  struct Fonts {
    static let light_13 = Font.system(
      size: 13,
      weight: .light,
      design: .default
    )
    static let regular_16 = Font.system(
      size: 16,
      weight: .regular,
      design: .default
    )
    static let medium_18 = Font.system(
      size: 18,
      weight: .medium,
      design: .default
    )
    static let semibold_35 = Font.system(
      size: 35,
      weight: .semibold,
      design: .default
    )
  }
  
  struct Spacing {
    /// 2.5 pt
    static let extraSmall: CGFloat = 2.5
    /// 5 pt
    static let small: CGFloat = 5
    /// 15 pt
    static let medium: CGFloat = 15
    /// 25 pt
    static let large: CGFloat = 20
  }
}
