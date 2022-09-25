import Foundation

protocol HomeViewModelFactory {
  func create() -> HomeViewModel
}

struct HomeViewModel {
  struct ButtonData: Hashable {
    let title: String
  }
  
  let buttons: [ButtonData]
  let particleEffect: URL?
}
