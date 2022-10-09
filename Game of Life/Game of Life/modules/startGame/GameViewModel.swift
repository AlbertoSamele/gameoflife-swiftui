import Foundation

struct GameViewModel {
  let content = GameContent()
  let gridSize: Int
  let populatedTiles: Set<GameCell>
  let isPlaying: Bool
}
