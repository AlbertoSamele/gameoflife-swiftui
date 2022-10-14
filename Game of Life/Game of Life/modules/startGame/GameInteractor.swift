import Foundation

class GameInteractor: ObservableObject {
  // MARK: - Computed properties
  
  private var turnSecondsLength: Double {
    Double(1) / Double(appState.settings.speed)
  }
  
  // MARK: - Private properties
  
  private let gameQueue = DispatchQueue(label: "com.gameoflife.gameinteractor", qos: .userInteractive)
  private var gameTurnMaker: Timer?
  
  // MARK: - Datasource properties
  
  @Published
  private(set) var viewModel: GameViewModel!
  @Published
  private var appState: AppState
  private var populatedCells: Set<GameCell> = []
  private var previousGameSetup: Set<GameCell> = []
  private var emptyCells: Set<GameCell> = []
  private var isPlaying = false
  
  // MARK: - Inits
  
  init(appState: AppState) {
    self.appState = appState
    viewModel = buildViewModel()
  }
  
  // MARK: - Public methods
  
  func closeGame() {
    gameTurnMaker?.invalidate()
    appState.router.pop()
  }
  
  func play() {
    guard !isPlaying else {
      return
    }
    
    initializeEmptyCells()
    previousGameSetup = populatedCells
    isPlaying = true
    
    gameTurnMaker = Timer.scheduledTimer(withTimeInterval: turnSecondsLength, repeats: true) { _ in
      self.gameQueue.async { [weak self] in
        self?.takeTurn()
      }
    }
  }
  
  func clear() {
    guard !isPlaying else {
      return
    }
    
    initializeEmptyCells()
    previousGameSetup = []
    populatedCells = []
    emptyCells = []
    
    viewModel = buildViewModel()
  }
  
  func reset() {
    gameTurnMaker?.invalidate()
    isPlaying = false
    self.gameQueue.async { [weak self] in
      guard let self = self else {
        return
      }
      
      self.populatedCells = self.previousGameSetup
      self.emptyCells = []
      
      DispatchQueue.main.async {
        self.viewModel = self.buildViewModel()
      }
    }
  }
  
  func toggleCell(row: Int, column: Int) {
    let tile = GameCell(row: row, column: column)
    if populatedCells.contains(tile) {
      populatedCells.remove(tile)
    } else {
      populatedCells.insert(tile)
    }
    
    viewModel = buildViewModel()
  }
  
  func randomPopulate() {
    guard !isPlaying else {
      return
    }
    
    populatedCells = []
    
    let gridSize = appState.settings.gridSize
    let numberOfCells = gridSize * gridSize
    let numberOfPopulatedCells = Int.random(in: 1...numberOfCells)
    
    for _ in 0..<numberOfPopulatedCells {
      let row = Int.random(in: 0..<gridSize)
      let column = Int.random(in: 0..<gridSize)
      populatedCells.insert(.init(row: row, column: column))
    }
    
    viewModel = buildViewModel()
  }
  
  // MARK: - Private methods
  
  private func initializeEmptyCells() {
    emptyCells = []
    
    for row in 0..<appState.settings.gridSize {
      for column in 0..<appState.settings.gridSize {
        let cell = GameCell(row: row, column: column)
        if !populatedCells.contains(cell) {
          emptyCells.insert(cell)
        }
      }
    }
  }
  
  private func takeTurn() {
    var newPopulatedCells = populatedCells
    var newEmptyCells = emptyCells
    
    populatedCells.forEach {
      let neighbours = $0.neighbours(for: appState.settings.gridSize)
        .filter { populatedCells.contains($0) }
      
      if neighbours.count != 2 && neighbours.count != 3 {
        newPopulatedCells.remove($0)
        newEmptyCells.insert($0)
      }
    }
  
    emptyCells.forEach {
      let neighbours = $0.neighbours(for: appState.settings.gridSize)
        .filter { populatedCells.contains($0) }
      
      if neighbours.count == 3 {
        newEmptyCells.remove($0)
        newPopulatedCells.insert($0)
      }
    }
    
    populatedCells = newPopulatedCells
    emptyCells = newEmptyCells
    
    DispatchQueue.main.async {
      self.viewModel = self.buildViewModel()
    }
  }
  
  private func buildViewModel() -> GameViewModel {
    .init(
      gridSize: appState.settings.gridSize,
      populatedTiles: populatedCells,
      isPlaying: isPlaying
    )
  }
}

