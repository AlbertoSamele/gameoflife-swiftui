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
  struct SpeedMetadata {
    var speed: Int
    let maxSpeed: Int
    let minSpeed: Int
  }
  
  var grid: GridMetadata
  var speed: SpeedMetadata
}

