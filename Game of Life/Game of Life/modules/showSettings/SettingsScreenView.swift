import Foundation
import SwiftUI

struct SettingsScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: SettingsInteractor
  
  // MARK: - Body
  
  var body: some View {
    VStack {
      ZStack(alignment: .leading) {
        Button(action: onBackButtonTapped)  {
          Image("back-arrow")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .tint(AppAppearance.Colors.color_313031)
            .frame(width: 22.5, height: 22.5)
        }
        Text("Settings")
          .font(AppAppearance.Fonts.medium_18)
          .frame(maxWidth: .infinity)
      }
      .padding(.horizontal, AppAppearance.Spacing.large)
      .padding(.top, AppAppearance.Spacing.small)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Slider(
        value: $interactor.viewModel.grid.size,
        min: interactor.viewModel.grid.minSize,
        max: interactor.viewModel.grid.maxSize
      )
      .frame(width: 250)
      
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(AppAppearance.Colors.color_ffffff)
  }
  
  // MARK: - Private methods
  
  private func onBackButtonTapped() {
    interactor.closeSettings()
  }
}

// MARK: - SettingsScreenView+Slider

private extension SettingsScreenView {
  struct Slider: View {
    // MARK: - Datasource properties
    
    @Binding
    var value: Int
    let min: Int
    let max: Int
    var step: Int = 1
    var thumbSize: CGFloat = 30
    
    // MARK: - Body
    
    var body: some View {
      ZStack(alignment: .top) {
        AppAppearance.Colors.color_313031
          .frame(height: 3)
          .offset(x: 0, y: thumbSize / 2)
        
        VStack(spacing: AppAppearance.Spacing.extraSmall) {
          AppAppearance.Colors.color_313031
            .frame(width: 12.5, height: thumbSize)
          Text("\(value)")
            .font(AppAppearance.Fonts.light_13)
        }
        .gesture(
          DragGesture()
            .onChanged(onThumbDrag(gesture:))
        )
      }
    }
    
    // MARK: - Private methods
    
    private func onThumbDrag(gesture: DragGesture.Value) {
      
    }
  }
}

// MARK: - Preview

struct SettingsScreenView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsScreenView(
      interactor: .init(
        appState: .init(initialRoute: .settings)
      )
    )
  }
}
