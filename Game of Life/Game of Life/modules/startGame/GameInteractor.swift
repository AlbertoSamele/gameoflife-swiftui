import Foundation

class GameInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  private(set) var viewModel: GameViewModel!
  @Published
  private var appState: AppState
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
    viewModel = buildViewModel()
  }
  
  // MARK: - Public methods
  
  func closeGame() {
    appState.router.pop()
  }
  
  // MARK: - Private methods
  
  private func buildViewModel() -> GameViewModel {
    .init(gridSize: appState.settings.gridSize)
  }
}

