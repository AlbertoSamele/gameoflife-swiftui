import Foundation
import SwiftUI

struct NavBar: View {
  // MARK: - Binding properties
  
  let onBack: () -> Void
  
  // MARK: - Datasource properties
  
  let title: String
  
  // MARK: - Body
  
  var body: some View {
    ZStack(alignment: .leading) {
      Button(action: onBack)  {
        Image("back-arrow")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .tint(AppAppearance.Colors.color_313031)
          .frame(width: 22.5, height: 22.5)
      }
      Text(title)
        .font(AppAppearance.Fonts.medium_18)
        .frame(maxWidth: .infinity)
    }
  }
}
