import Foundation
import SwiftUI

struct HomeScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: HomeInteractor
  
  // MARK: - Body
  
  var body: some View {
    VStack {
      ForEach(interactor.data.buttons, id: \.self) { button in
        ActionButton(
          title: button.title,
          onTap: {
            interactor.triggerAction(of: button)
          }
        )
          .frame(width: 160, height: 40)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(AppAppearance.Colors.color_ffffff)
  }
}

// MARK: - HomeScreenView+UI

private extension HomeScreenView {
  // MARK: - ActionButton
  
  struct ActionButton: View {
    // MARK: - Datasoure properties
    
    let title: String
    let onTap: () -> Void
    var color: Color = AppAppearance.Colors.color_313031
    
    // MARK: - Body
    
    var body: some View {
      Button(action: onButtonTapped) {
        Text(title)
          .foregroundColor(color)
          .font(AppAppearance.Fonts.regular_16)
      }
      .buttonStyle(.plain)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .border(color, width: 2)
    }
    
    // MARK: - Private methods
    
    private func onButtonTapped() {
      
    }
  }
}

// MARK: - Preview

struct HomeScreenView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreenView(
      interactor: HomeInteractor()
    )
  }
}
