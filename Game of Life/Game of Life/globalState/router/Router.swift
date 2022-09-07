import Foundation

enum Route: Equatable {
  case home
  case settings
}

enum PresentationMode: Equatable {
  case push
  case pop
  case replace
}

struct RouteData: Equatable {
  private let id = UUID()
  let route: Route
  let presentationMode: PresentationMode
}

protocol Router {
  var currentRoute: RouteData { get }
  var modalRoute: Router? { get }
  
  mutating func push(_ route: Route)
  mutating func pop()
  func peek() -> Route?
  mutating func present(_ route: Route)
  mutating func dismiss()
}
