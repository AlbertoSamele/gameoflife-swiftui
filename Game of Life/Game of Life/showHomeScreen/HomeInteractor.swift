import Foundation

class HomeInteractor: ObservableObject {
  // MARK: - Computed properties
  
  var data: HomeViewModel {
    .init(
      buttons: [
        .init(title: "Start"),
        .init(title: "Settings")
      ]
    )
  }
  
  // MARK: - Public methods
  
  func triggerAction(of button: HomeViewModel.ButtonData) {
    
  }
}
