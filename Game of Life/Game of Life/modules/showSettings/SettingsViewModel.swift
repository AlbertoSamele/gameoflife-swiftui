import Foundation

protocol SettingsViewModelFactory {
  func create(with settings: AppState.Settings) -> SettingsViewModel
}

struct SettingsViewModel {
  struct GridMetadata {
    var size: Int
    let maxSize: Int
    let minSize: Int
  }
  
  var grid: GridMetadata
}

