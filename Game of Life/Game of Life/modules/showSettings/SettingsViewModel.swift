import Foundation

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
  
  let content = SettingsContent()
  var grid: GridMetadata
  var speed: SpeedMetadata
}

