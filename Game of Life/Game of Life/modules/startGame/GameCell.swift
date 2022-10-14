import Foundation

struct GameCell: Hashable, Equatable {
  // MARK: - Datasource properties
  
  let row: Int
  let column: Int
  
  // MARK: - Public methods
  
  func neighbours(for gridSize: Int) -> [GameCell] {
      return [
        topLeftNeighbour(),
        topNeighbour(),
        topRightNeighbour(gridSize: gridSize),
        leftNeighbour(),
        rightNeighbour(gridSize: gridSize),
        bottomLeftNeighbour(gridSize: gridSize),
        bottomNeighbour(gridSize: gridSize),
        bottomRightNeighbour(gridSize: gridSize),
      ].compactMap { $0 }
  }
  
  // MARK: - Private methods
  
  private func topLeftNeighbour() -> GameCell? {
    guard row > 0, column > 0 else {
      return nil
    }
    return .init(row: row - 1, column: column - 1)
  }
  
  private func topNeighbour() -> GameCell? {
    guard row > 0 else {
      return nil
    }
    return .init(row: row - 1, column: column)
  }
  
  private func topRightNeighbour(gridSize: Int) -> GameCell? {
    guard row > 0, column + 1 < gridSize else {
      return nil
    }
    return .init(row: row - 1, column: column + 1)
  }
  
  private func leftNeighbour() -> GameCell? {
    guard column > 0 else {
      return nil
    }
    return .init(row: row, column: column - 1)
  }
  
  private func rightNeighbour(gridSize: Int) -> GameCell? {
    guard column + 1 < gridSize else {
      return nil
    }
    return .init(row: row, column: column + 1)
  }
  
  private func bottomLeftNeighbour(gridSize: Int) -> GameCell? {
    guard row + 1 < gridSize, column > 0 else {
      return nil
    }
    return .init(row: row + 1, column: column - 1)
  }
  
  private func bottomNeighbour(gridSize: Int) -> GameCell? {
    guard row + 1 < gridSize else {
      return nil
    }
    return .init(row: row + 1, column: column)
  }
  
  private func bottomRightNeighbour(gridSize: Int) -> GameCell? {
    guard row + 1 < gridSize, column + 1 < gridSize else {
      return nil
    }
    return .init(row: row + 1, column: column + 1)
  }
}
