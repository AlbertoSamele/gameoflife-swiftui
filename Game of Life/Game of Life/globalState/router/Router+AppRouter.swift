import Foundation

struct AppRouter: Router {
  // MARK: - Datasource properties
  
  private(set) var currentRoute: RouteData
  private(set) var modalRoute: Router?
  private var routesStack: [Route]
  
  // MARK: - Inits
  
  init(initialRoute: Route) {
    routesStack = [initialRoute]
    currentRoute = .init(
      route: initialRoute,
      presentationMode: .replace
    )
  }
  
  // MARK: - Public methods
  
  mutating func push(_ route: Route) {
    if let _ = modalRoute {
      self.modalRoute?.push(route)
      return
    }
    
    routesStack.append(route)
    currentRoute = .init(
      route: route,
      presentationMode: .push
    )
  }
  
  mutating func pop() {
    if let _ = modalRoute {
      self.modalRoute?.pop()
      return
    }
    guard routesStack.count > 1 else {
      print("Attempted to pop root Route. Ignoring")
      return
    }
    
    routesStack.removeLast()
    currentRoute = .init(
      route: routesStack[routesStack.count - 1],
      presentationMode: .pop
    )
  }
  
  func peek() -> Route? {
    guard routesStack.count > 1 else {
      return nil
    }
    return routesStack[routesStack.count - 2]
  }
  
  mutating func present(_ route: Route) {
    modalRoute?.dismiss()
    modalRoute = AppRouter(initialRoute: route)
  }
  
  mutating func dismiss() {
    modalRoute = nil
  }
}
