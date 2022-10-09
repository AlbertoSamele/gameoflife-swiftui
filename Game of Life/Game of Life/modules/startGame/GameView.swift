import Foundation
import SwiftUI

struct GameView: View {
  // MARK: - UI properties
  
  private let selectedTileColor = AppAppearance.Colors.color_313031
  private let deselectedTileColor = AppAppearance.Colors.color_ffffff
  
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: GameInteractor
  @State
  private var canRenderGameGrid = false
  @State
  private var loaderContent: String?
  
  // MARK: - Body
  
  var body: some View {
    GeometryReader { proxy in
      let cellSize = proxy.size.width / Double(interactor.viewModel.gridSize)
      ZStack(alignment: .top) {
        NavBar(
          onBack: onBackArrowTapped,
          title: nil
        )
        .padding(.horizontal, AppAppearance.Spacing.large)
        .padding(.top, AppAppearance.Spacing.small)
        
        VStack(spacing: AppAppearance.Spacing.hyperLarger) {
          if canRenderGameGrid {
            gameGrid(
              cellSize: cellSize,
              onCellTap: interactor.toggleCell(row:column:)
            )
            .drawingGroup()
            
            VStack {
              ActionButton(
                title: interactor.viewModel.content.randomPopulatePrompt,
                onTap: interactor.randomPopulate
              )
              .frame(width: 160, height: 40)
              
              ActionButton(
                title: interactor.viewModel.content.playPrompt,
                onTap: interactor.play
              )
              .frame(width: 160, height: 40)
            }
          } else {
            loader(title: loaderContent ?? "")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
        loaderContent = interactor.viewModel.content.setupWarning
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.canRenderGameGrid = true
        }
      }
    }
  }
  
  // MARK: - Private methods
  
  private func onBackArrowTapped() {
    loaderContent = interactor.viewModel.content.teardownWarning
    self.canRenderGameGrid = false
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.interactor.closeGame()
    }
  }
}

// MARK: - GameView+UI

private extension GameView {
  @ViewBuilder
  func gameGrid(
    cellSize: CGFloat,
    onCellTap: @escaping (_ row: Int, _ column: Int) -> Void
  ) -> some View {
    VStack(spacing: 0) {
      ForEach(0..<interactor.viewModel.gridSize) { row in
        HStack(spacing: 0) {
          ForEach(0..<interactor.viewModel.gridSize) { column in
            let isSelected = interactor.viewModel.populatedTiles.contains(.init(row: row, column: column))
            
            (isSelected ? selectedTileColor : deselectedTileColor)
              .border(AppAppearance.Colors.color_313031, width: 0.5)
              .frame(width: cellSize, height: cellSize)
              .onTapGesture {
                onCellTap(row, column)
              }
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func loader(title: String) -> some View {
    let lottieSize: CGFloat = 100
    
    VStack(spacing: AppAppearance.Spacing.extraLarge) {
      LottieAnimationView(
        isLoading: .constant(true),
        size: .init(width: lottieSize, height: lottieSize)
      )
        .frame(width: lottieSize, height: lottieSize)
      Text(title)
        .font(AppAppearance.Fonts.light_13)
        .foregroundColor(AppAppearance.Colors.color_313031)
    }
  }
}
