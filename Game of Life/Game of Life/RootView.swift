import SwiftUI

struct RootView: View {
  // MARK: - Computed properties
  
  var size: CGSize { UIScreen.main.bounds.size }
  
  // MARK: - Private properties
  
  private var navigator: Navigator {
    NativeNavigation(navigatable: self)
  }
  
  // MARK: - Datasource properties
  
  @StateObject
  var appState: AppState = .init()
  @State
  var root: RouteType = Route.home
  @State
  var rootOffset: NavigatableTransforms = .identity()
  @State
  var willBeRoot: RouteType? = nil
  @State
  var willBeRootOffset: NavigatableTransforms = .identity()
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      createView(for: root)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(x: rootOffset.x, y: rootOffset.y)
      
      if let willBeRoot = willBeRoot {
        createView(for: willBeRoot)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .offset(x: willBeRootOffset.x, y: willBeRootOffset.y)
      }
    }
    .onChange(of: appState.router.currentRoute) { newRoute in
      present(
        newRoute.route,
        from: root,
        with: newRoute.presentationMode
      )
    }
  }
  
  // MARK: - Private methods
  
  private func present(
    _ toRoute: RouteType,
    from fromRoute: RouteType,
    with presentationMode: PresentationMode
  ) {
    switch presentationMode {
    case .push:
      navigator.push(from: fromRoute, to: toRoute)
    case .pop:
      navigator.pop(from: fromRoute, to: toRoute)
    case .replace:
      break
    }
  }
}

// MARK: - RootView+Factory

extension RootView {
  @ViewBuilder
  private func createView(for route: RouteType) -> some View {
    
    switch route as? Route {
    case .home:
      HomeScreenView(
        interactor: .init(
          appState: appState
        )
      )
    case .settings:
      SettingsScreenView(
        interactor: .init(
          appState: appState
        )
      )
    case .none:
      EmptyView()
    }
  }
}

// MARK: - RootView+Navigatable

extension RootView: Navigatable {
  var rootState: State<RouteType> {
    get { _root }
    set { _root = newValue }
  }
  
  var rootOffsetState: State<NavigatableTransforms> {
    get { _rootOffset }
    set { _rootOffset = newValue }
  }
  
  var willBeRootState: State<RouteType?> {
    get { _willBeRoot }
    set { _willBeRoot = newValue }
  }
  
  var willBeRootOffsetState: State<NavigatableTransforms> {
    get { _willBeRootOffset }
    set { _willBeRootOffset = newValue }
  }
}

// MARK: - Route+RouteType

extension Route: RouteType { }
