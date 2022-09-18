import Foundation
import SwiftUI

class AppState: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  var router: Router
  @Published
  private(set) var settings: Settings = .init()
  
  // MARK: - Inits
  
  init(
    initialRoute: Route = .home
  ) {
    router = AppRouter(initialRoute: initialRoute)
    settings.retrievePersistent()
  }
  
  // MARK: - Public methods
  
  func save(settings: Settings) {
    settings.persistentSave()
    self.settings = settings
  }
}

// MARK: AppState+Persistency

private extension AppState.Settings {
  private var fileName: String { "AppSettings" }
  
  func persistentSave(
    fileManager: FileManager = FileManager.default
  ) {
    guard let saveDirectory = saveDirectory(with: fileManager) else {
      return
    }
    
    var isDirectory: ObjCBool = true
    if !fileManager.fileExists(atPath: saveDirectory.absoluteString, isDirectory: &isDirectory) {
        try? fileManager.createDirectory(at: saveDirectory, withIntermediateDirectories: true)
    }
    
    let data = try? PropertyListEncoder().encode(self)
    try? data?.write(
      to: saveDirectory.appendingPathComponent("/\(fileName)"),
      options: .atomic
    )
  }
  
  mutating func retrievePersistent(
    fileManager: FileManager = FileManager.default
  ) {
    guard let saveDirectory = saveDirectory(with: fileManager) else {
      return
    }
    
    guard
      let data = try? Data(contentsOf: saveDirectory.appendingPathComponent("/\(fileName)")),
      let savedSettings = try? PropertyListDecoder().decode(AppState.Settings.self, from: data)
    else {
      return
    }
    
    self = savedSettings
  }
  
  private func saveDirectory(with fileManager: FileManager) -> URL? {
    fileManager.urls(
      for: .documentDirectory,
      in: .userDomainMask
    )
    .first?
    .appendingPathComponent("Settings")
  }
}
