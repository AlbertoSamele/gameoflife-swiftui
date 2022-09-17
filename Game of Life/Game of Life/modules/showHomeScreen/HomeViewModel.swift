import Foundation

protocol HomeViewModelFactory {
  func create() -> HomeViewModel
}

class HomeViewModel: ObservableObject {
  struct ButtonData: Hashable {
    let title: String
  }
  
  let buttons: [ButtonData]
    
  init(buttons: [ButtonData]) {
    self.buttons = buttons
  }
}
