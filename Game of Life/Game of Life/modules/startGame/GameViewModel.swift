import Foundation

struct GameViewModel {
  let content = GameContent()
  let gridSize: Int
  let populatedTiles: Set<GameInteractor.GameCell>
}
