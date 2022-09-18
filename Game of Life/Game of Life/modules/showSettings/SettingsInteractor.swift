import Foundation

class SettingsInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  private let appState: AppState
  @Published
  var viewModel: SettingsViewModel
  
  // MARK: - Inits
  
  init(
    appState: AppState,
    viewModelFactory: SettingsViewModelFactory = ConcreteSettingsViewModelFactory()
  ) {
    self.appState = appState
    viewModel = viewModelFactory.create(with: appState.settings)
  }
  
  func closeSettings() {
    appState.router.pop()
  }
}

private struct ConcreteSettingsViewModelFactory: SettingsViewModelFactory {
  func create(with settings: AppState.Settings) -> SettingsViewModel {
    .init(
      grid: .init(
        size: settings.gridSize,
        maxSize: 90,
        minSize: 15
      ),
      speed: .init(
        speed: settings.speed,
        maxSpeed: 10,
        minSpeed: 1
      )
    )
  }
}
