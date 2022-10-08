import Foundation
import SwiftUI

struct GameView: View {
  // MARK: - Datasource properties
  
  let interactor: GameInteractor
  
  // MARK: - Body
  
  var body: some View {
    GeometryReader { proxy in
      let cellSize = proxy.size.width / Double(interactor.viewModel.gridSize)
      ZStack(alignment: .top) {
        NavBar(
          onBack: interactor.closeGame,
          title: nil
        )
        .padding(.horizontal, AppAppearance.Spacing.large)
        .padding(.top, AppAppearance.Spacing.small)
        
        VStack(spacing: 0) {
          ForEach(0..<interactor.viewModel.gridSize) { _ in
            HStack(spacing: 0) {
              ForEach(0..<interactor.viewModel.gridSize) { _ in
                Color.green
                  .border(AppAppearance.Colors.color_313031, width: 2)
                  .frame(width: cellSize, height: cellSize)
              }
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}
