import Foundation

class GameInteractor: ObservableObject {
  struct GameTile: Hashable, Equatable {
    let row: Int
    let column: Int
  }
  
  // MARK: - Datasource properties
  
  @Published
  private(set) var viewModel: GameViewModel!
  @Published
  private var appState: AppState
  private var populatedTiles: Set<GameTile> = []
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
    viewModel = buildViewModel()
  }
  
  // MARK: - Public methods
  
  func closeGame() {
    appState.router.pop()
  }
  
  func toggleTile(row: Int, column: Int) {
    let tile = GameTile(row: row, column: column)
    if populatedTiles.contains(tile) {
      populatedTiles.remove(tile)
    } else {
      populatedTiles.insert(tile)
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

