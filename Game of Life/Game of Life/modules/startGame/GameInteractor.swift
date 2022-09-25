import Foundation

class GameInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  private(set) var viewModel: GameViewModel
  @Published
  private var appState: AppState
  
  // MARK: - Inits
  
  init(
    appState: AppState,
    viewModelFactory: GameViewModelFactory = ConcreteGameViewModelFactory()
  ) {
    self.appState = appState
    viewModel = viewModelFactory.create(appState: appState)
  }
}

// MARK: - ConcreteGameViewModelFactory

struct ConcreteGameViewModelFactory: GameViewModelFactory {
  func create(appState: AppState) -> GameViewModel {
    .init(gridSize: appState.settings.gridSize)
  }
}

