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
  var underimposedRoot: RouteType? = nil
  @State
  var underimposedTransforms: NavigatableTransforms = .identity()
  @State
  var root: RouteType = Route.home
  @State
  var rootTransforms: NavigatableTransforms = .identity()
  @State
  var overimposedRoot: RouteType? = nil
  @State
  var overimposedTransforms: NavigatableTransforms = .identity()
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      if let underimposedRoot = underimposedRoot {
        createView(for: underimposedRoot)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .offset(x: underimposedTransforms.x, y: underimposedTransforms.y)
      }
      
      createView(for: root)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .offset(x: rootTransforms.x, y: rootTransforms.y)
      
      if let overimposedRoot = overimposedRoot {
        createView(for: overimposedRoot)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .offset(x: overimposedTransforms.x, y: overimposedTransforms.y)
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
  
  var rootTransformsState: State<NavigatableTransforms> {
    get { _rootTransforms }
    set { _rootTransforms = newValue }
  }
  
  var overimposedRootState: State<RouteType?> {
    get { _overimposedRoot }
    set { _overimposedRoot = newValue }
  }
  
  var overimposedTransformsState: State<NavigatableTransforms> {
    get { _overimposedTransforms }
    set { _overimposedTransforms = newValue }
  }
  
  var underimposedRootState: State<RouteType?> {
    get { _underimposedRoot }
    set { _underimposedRoot = newValue }
  }
  
  var underimposedTransformsState: State<NavigatableTransforms> {
    get { _underimposedTransforms }
    set { _underimposedTransforms = newValue }
  }
}

// MARK: - Route+RouteType

extension Route: RouteType { }
