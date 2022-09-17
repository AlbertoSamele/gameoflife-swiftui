import Foundation

class HomeInteractor: ObservableObject {
  // MARK: - Datasource properties
  
  @Published
  var viewModel: HomeViewModel
  
  // MARK: - Inits
  
  init(
    viewModelFactory: HomeViewModelFactory = ConcreteHomeViewModelFactory()
  ) {
    viewModel = viewModelFactory.create()
  }
  
  // MARK: - Public methods
  
  func triggerAction(of button: HomeViewModel.ButtonData) {
    
  }
}

// MARK: - Factory methods

private class ConcreteHomeViewModelFactory: HomeViewModelFactory {
  func create() -> HomeViewModel {
    .init(
      buttons: [
        .init(title: "Start"),
        .init(title: "Settings")
      ]
    )
  }
}
