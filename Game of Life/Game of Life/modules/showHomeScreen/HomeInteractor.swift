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
    appState.router.push(.settings)
  }
}

// MARK: - ViewModel factory

private class ConcreteHomeViewModelFactory: HomeViewModelFactory {
  func create() -> HomeViewModel {
    .init(
      buttons: [
        .init(title: "Start"),
        .init(title: "Settings")
      ],
      particleEffect: Bundle.main.url(
        forResource: "particle-effect",
        withExtension: ".mp4"
      )
    )
  }
}
