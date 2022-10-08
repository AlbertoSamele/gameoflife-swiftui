import Foundation

class HomeInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  var viewModel: HomeViewModel!
  @Published
  private var appState: AppState
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
    viewModel = buildViewModel()
  }
  
  // MARK: - Public methods
  
  func showSettings() {
    appState.router.push(.settings)
  }
  
  func startPlaying() {
    appState.router.push(.game)
  }
  
  // MARK: - Private methods
  
  private func buildViewModel() -> HomeViewModel {
    .init()
  }
}
