import Foundation
import SwiftUI

struct HomeScreenView: View {
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: HomeInteractor
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      PlayerView(
        url: Bundle.main.url(
          forResource: "particle-effect",
          withExtension: ".mp4"
        )
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      
      VStack(spacing: 0) {
        ForEach(
          interactor.viewModel.content.header.split(separator: " "),
          id: \.self
        ) {
          Text($0)
            .font(AppAppearance.Fonts.semibold_35)
        }
        Spacer()
      }
      .padding(.top, AppAppearance.Spacing.small)
      
      VStack {
        ActionButton(
          title: interactor.viewModel.content.startPrompt,
          onTap: interactor.startPlaying
        )
        .frame(width: 160, height: 40)
        ActionButton(
          title: interactor.viewModel.content.settingsPrompt,
          onTap: interactor.showSettings
        )
        .frame(width: 160, height: 40)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(AppAppearance.Colors.color_ffffff)
  }
}

// MARK: - Preview

struct HomeScreenView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreenView(
      interactor: .init(
        appState: .init(
          initialRoute: .home
        )
      )
    )
  }
}
