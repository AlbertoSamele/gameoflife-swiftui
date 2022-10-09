import Foundation

class SettingsInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  private let appState: AppState
  @Published
  var viewModel: SettingsViewModel!
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
    viewModel = buildViewModel()
  }
  
  // MARK: - Public methods
  
  func closeSettings() {
    if let viewModel {
      appState.save(
        settings: .init(
          gridSize: viewModel.grid.size,
          speed: viewModel.speed.speed
        )
      )
    }
    
    appState.router.pop()
  }
  
  // MARK: - Private methods
  
  private func buildViewModel() -> SettingsViewModel {
    .init(
      grid: .init(
        size: appState.settings.gridSize,
        maxSize: 100,
        minSize: 15
      ),
      speed: .init(
        speed: appState.settings.speed,
        maxSpeed: 10,
        minSpeed: 1
      )
    )
  }
}
