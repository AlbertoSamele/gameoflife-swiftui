import Foundation

struct HomeViewModel {
  struct ButtonData: Hashable {
    let title: String
  }
  
  let buttons: [ButtonData]
}
