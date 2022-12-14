import Foundation
import SwiftUI

struct GameView: View {
  // MARK: - UI properties
  
  private let selectedTileColor = AppAppearance.Colors.color_313031
  private let deselectedTileColor = AppAppearance.Colors.color_ffffff
  
  // MARK: - Datasource properties
  
  @ObservedObject
  var interactor: GameInteractor
  @GestureState
  private var gridDragLocation: CGPoint = .zero
  @State
  private var lastHighlightedDragCell: (row: Int, column: Int)?
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
        
        if canRenderGameGrid {
          VStack(spacing: AppAppearance.Spacing.hyperLarger) {
            gameGrid(
              cellSize: cellSize,
              onCellTap: interactor.toggleCell(row:column:)
            )
            .drawingGroup()
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
              .updating($gridDragLocation) { value, state, _ in
                state = value.location
              }
            )
            
            VStack {
              ActionButton(
                title: interactor.viewModel.isPlaying ?
                interactor.viewModel.content.resetPrompt : interactor.viewModel.content.randomPopulatePrompt,
                onTap: interactor.viewModel.isPlaying ? interactor.reset : interactor.randomPopulate
              )
              .frame(width: 160, height: 40)
              
              ActionButton(
                title: interactor.viewModel.content.clearPrompt,
                onTap: interactor.clear
              )
              .frame(width: 160, height: 40)
              .opacity(interactor.viewModel.isPlaying ? 0 : 1)
              
              ActionButton(
                title: interactor.viewModel.content.playPrompt,
                onTap: interactor.play
              )
              .frame(width: 160, height: 40)
              .opacity(interactor.viewModel.isPlaying ? 0 : 1)
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          
        } else {
          loader(title: loaderContent ?? "")
            .offset(y: -AppAppearance.Spacing.extraLarge)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
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
              .background(cellDragReader(row: row, column: column))
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func cellDragReader(row: Int, column: Int) -> some View {
    GeometryReader { (geometry) -> AnyView in
      if geometry.frame(in: .global).contains(gridDragLocation),
         (row != lastHighlightedDragCell?.row || column != lastHighlightedDragCell?.column)
      {
        DispatchQueue.main.async {
          self.lastHighlightedDragCell = (row: row, column: column)
          self.interactor.toggleCell(row: row, column: column)
        }
      }
      return AnyView(EmptyView())
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
