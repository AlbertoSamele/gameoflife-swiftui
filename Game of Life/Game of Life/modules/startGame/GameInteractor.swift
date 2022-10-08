import Foundation

class GameInteractor: ObservableObject {
  struct GameCell: Hashable, Equatable {
    let row: Int
    let column: Int
  }
  
  // MARK: - Datasource properties
  
  @Published
  private(set) var viewModel: GameViewModel!
  @Published
  private var appState: AppState
  private var populatedTiles: Set<GameCell> = []
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
    viewModel = buildViewModel()
  }
  
  // MARK: - Public methods
  
  func closeGame() {
    appState.router.pop()
  }
  
  func toggleCell(row: Int, column: Int) {
    let tile = GameCell(row: row, column: column)
    if populatedTiles.contains(tile) {
      populatedTiles.remove(tile)
    } else {
      populatedTiles.insert(tile)
    }
    
    viewModel = buildViewModel()
  }
  
  func randomPopulate() {
    populatedTiles = []
    
    let gridSize = appState.settings.gridSize
    let numberOfCells = gridSize * gridSize
    let numberOfPopulatedCells = Int.random(in: 1...numberOfCells)
    
    for _ in 0..<numberOfPopulatedCells {
      let row = Int.random(in: 0..<gridSize)
      let column = Int.random(in: 0..<gridSize)
      populatedTiles.insert(.init(row: row, column: column))
    }
    
    viewModel = buildViewModel()
  }
  
  // MARK: - Private methods
  
  private func buildViewModel() -> GameViewModel {
    .init(
      gridSize: appState.settings.gridSize,
      populatedTiles: populatedTiles
    )
  }
}

