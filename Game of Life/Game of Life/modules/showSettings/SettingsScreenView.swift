import Foundation
import SwiftUI

struct SettingsScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: SettingsInteractor
  
  // MARK: - Body
  
  var body: some View {
    ZStack(alignment: .top) {
      PlayerView(
        url: Bundle.main.url(
          forResource: "particle-effect",
          withExtension: ".mp4"
        )
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      
      ZStack(alignment: .leading) {
        Button(action: interactor.closeSettings)  {
          Image("back-arrow")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .tint(AppAppearance.Colors.color_313031)
            .frame(width: 22.5, height: 22.5)
        }
        Text(interactor.viewModel.content.header)
          .font(AppAppearance.Fonts.medium_18)
          .frame(maxWidth: .infinity)
      }
      .padding(.horizontal, AppAppearance.Spacing.large)
      .padding(.top, AppAppearance.Spacing.small)
      
      VStack(alignment: .leading, spacing: AppAppearance.Spacing.large) {
        slider(
          title: interactor.viewModel.content.changeGridSizePrompt,
          value: $interactor.viewModel.grid.size,
          minValue: interactor.viewModel.grid.minSize,
          maxValue: interactor.viewModel.grid.maxSize
        )
        slider(
          title: interactor.viewModel.content.changeSpeedPrompt,
          value: $interactor.viewModel.speed.speed,
          minValue: interactor.viewModel.speed.minSpeed,
          maxValue: interactor.viewModel.speed.maxSpeed
        )
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(AppAppearance.Colors.color_ffffff)
  }
}

// MARK: - SettingsScreenView+UI

private extension SettingsScreenView {
  @ViewBuilder
  func slider(
    title: String,
    value: Binding<Int>,
    minValue: Int,
    maxValue: Int
  ) -> some View {
    HStack() {
      Text(title)
        .font(AppAppearance.Fonts.regular_16)
        .offset(y: -7)
      Spacer()
      SliderView(
        value: value,
        min: minValue,
        max: maxValue
      )
      .frame(width: 250, height: 46)
    }
    .frame(width: 340)
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
