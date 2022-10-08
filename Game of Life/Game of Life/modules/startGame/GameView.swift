import Foundation
import SwiftUI

struct GameView: View {
  // MARK: - UI properties
  
  private let selectedTileColor = AppAppearance.Colors.color_313031
  private let deselectedTileColor = AppAppearance.Colors.color_9a8d9f
  
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: GameInteractor
  
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
          ForEach(0..<interactor.viewModel.gridSize) { row in
            HStack(spacing: 0) {
              ForEach(0..<interactor.viewModel.gridSize) { column in
                (interactor.viewModel.populatedTiles.contains(.init(row: row, column: column)) ? selectedTileColor : deselectedTileColor)
                  .border(AppAppearance.Colors.color_313031, width: 0.5)
                  .frame(width: cellSize, height: cellSize)
                  .onTapGesture {
                    interactor.toggleTile(row: row, column: column)
                  }
              }
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .drawingGroup()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}