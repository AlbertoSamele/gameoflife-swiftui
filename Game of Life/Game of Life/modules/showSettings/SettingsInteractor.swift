import Foundation

class SettingsInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  private let appState: AppState
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
  }
  
  func push() {
    appState.router.push(.home)
  }
}
