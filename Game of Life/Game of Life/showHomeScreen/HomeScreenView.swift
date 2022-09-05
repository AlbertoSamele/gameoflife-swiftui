import Foundation
import SwiftUI

struct HomeScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: HomeInteractor
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        ForEach(["Game", "of", "Life"], id: \.self) { text in
          Text(text)
            .font(AppAppearance.Fonts.semibold_35)
        }
        Spacer()
      }
      .padding(.top, AppAppearance.Spacing.small)
      
      VStack {
        ForEach(interactor.viewModel.buttons, id: \.self) { button in
          ActionButton(
            title: button.title,
            onTap: {
              interactor.triggerAction(of: button)
            }
          )
            .frame(width: 160, height: 40)
        }
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
    var animationDuration: Double = 0.1
    var animationOffset: CGFloat = 3
    @State
    private var yOffset: CGFloat = 0
    @State
    private var isAnimating: Bool = false
    
    // MARK: - Body
    
    var body: some View {
      Button(action: onButtonTapped) {
        Text(title)
          .foregroundColor(color)
          .font(AppAppearance.Fonts.regular_16)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .contentShape(Rectangle())
      }
      .buttonStyle(StaticButtonStyle())
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .border(color, width: 2)
      .offset(x: 0, y: yOffset)
    }
    
    // MARK: - Private methods
    
    private func onButtonTapped() {
      guard !isAnimating else { return }
      isAnimating = true
      
      withAnimation(
        .easeInOut(duration: animationDuration / 2)
      ) {
        yOffset = animationOffset
      }
      withAnimation(
        .easeInOut(duration: animationDuration / 2)
        .delay(animationDuration / 2)
      ) {
        yOffset = 0
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
        isAnimating = false
        onTap()
      }
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
