import Foundation

protocol GameViewModelFactory {
  func create(appState: AppState) -> GameViewModel
}

struct GameViewModel {
  let gridSize: Int
}
