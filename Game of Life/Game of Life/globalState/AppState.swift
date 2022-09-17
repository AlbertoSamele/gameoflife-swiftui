import Foundation
import SwiftUI

class AppState: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  var router: Router
  @Published
  var settings: Settings = .init()
  
  // MARK: - Inits
  
  init(
    initialRoute: Route = .home
  ) {
    router = AppRouter(initialRoute: initialRoute)
  }
}
