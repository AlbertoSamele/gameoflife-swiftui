import Foundation

class HomeInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  var viewModel: HomeViewModel
  @Published
  private var appState: AppState
  
  // MARK: - Inits
  
  init(
    appState: AppState,
    viewModelFactory: HomeViewModelFactory = ConcreteHomeViewModelFactory()
  ) {
    self.appState = appState
    viewModel = viewModelFactory.create()
  }
  
  // MARK: - Public methods
  
  func triggerAction(of button: HomeViewModel.ButtonData) {
    button.handler()
  }
  
  // MARK: - Private methods
  
  private func startGame() {
    appState.router.push(.game)
  }
  
  private func showSettings() {
    appState.router.push(.game)
  }
}

// MARK: - ViewModel factory

private struct ConcreteHomeViewModelFactory: HomeViewModelFactory {
  var buttonsFactory = HomeViewModel.ButtonDataFactory()
  let onStartGame: () -> Void
  let onShowSettings: () -> Void
  
  func create() -> HomeViewModel {
    .init(
      buttons: [
        buttonsFactory.create(.start, handler: onStartGame),
        buttonsFactory.create(.settings, handler: onShowSettings)
      ],
      particleEffect: Bundle.main.url(
        forResource: "particle-effect",
        withExtension: ".mp4"
      )
    )
  }
}
