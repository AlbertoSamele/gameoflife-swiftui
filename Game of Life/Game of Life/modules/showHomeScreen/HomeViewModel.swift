import Foundation

protocol HomeViewModelFactory {
  func create() -> HomeViewModel
}

struct HomeViewModel {
  struct ButtonData: Hashable {
    let title: String
    let handler: () -> Void
    
    fileprivate init(
      title: String,
      handler: @escaping () -> Void
    ) {
      self.title = title
      self.handler = handler
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(title)
    }
    
    static func == (lhs: HomeViewModel.ButtonData, rhs: HomeViewModel.ButtonData) -> Bool {
      lhs.title == rhs.title
    }
  }
  
  struct ButtonDataFactory {
    enum ButtonType {
      case start
      case settings
    }
    
    func create(
      _ type: ButtonType,
      handler: @escaping () -> Void)
    -> ButtonData {
      var title: String = ""
      switch type {
      case .start:
        title = "Start"
      case .settings:
        title = "Settings"
      }
      
      return .init(title: title, handler: handler)
    }
  }
  
  let buttons: [ButtonData]
  let particleEffect: URL?
}

