import SwiftUI

struct PuzzleView: View {
    @State var tiles: [UIImage]   // Tiles to display
    @State var gridSize: Int      // Grid size (e.g., 3x3)
    @State private var emptyIndex: Int // Index of the blank tile
    @State private var isSolved: Bool = false // Track if the puzzle is solved

    init(tiles: [UIImage], gridSize: Int) {
        self.gridSize = gridSize
        self._tiles = State(initialValue: PuzzleView.setupTiles(tiles: tiles, gridSize: gridSize))
        self._emptyIndex = State(initialValue: tiles.count - 1) // Blank tile starts at the last position
    }

    var body: some View {
        VStack {
            if isSolved {
                Text("Congratulations! Puzzle Solved!")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 2) {
                ForEach(tiles.indices, id: \.self) { index in
                    ZStack {
                        if index == emptyIndex {
                            // Represent the blank space
                            Rectangle()
                                .fill(Color.black.opacity(0.1)) // A subtle blank space
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            // Display the image tile
                            Image(uiImage: tiles[index])
                                .resizable()
                                .scaledToFit()
                                .border(canMove(tileIndex: index) ? Color.white : Color.clear, width: 4) // White border for movable tiles
                                .onTapGesture {
                                    handleTileTap(at: index)
                                }
                        }
                    }
                    .animation(.easeInOut, value: tiles) // Smooth sliding animation
                }
            }
            .padding()
        }
    }

    func handleTileTap(at index: Int) {
        if canMove(tileIndex: index) {
            withAnimation {
                tiles.swapAt(index, emptyIndex) // Swap the tapped tile with the blank one
                emptyIndex = index              // Update the blank space position
            }

            // Check if the puzzle is solved after every move
            checkIfSolved()
        }
    }

    func canMove(tileIndex: Int) -> Bool {
        // Get the row and column of the blank space and the tapped tile
        let emptyRow = emptyIndex / gridSize
        let emptyCol = emptyIndex % gridSize
        let tileRow = tileIndex / gridSize
        let tileCol = tileIndex % gridSize

        // Calculate row and column differences
        let rowDiff = abs(tileRow - emptyRow)
        let colDiff = abs(tileCol - emptyCol)

        // Valid move: tile must be adjacent to the blank space and within the same row or column
        return (rowDiff + colDiff == 1)
    }

    func checkIfSolved() {
        // Correct arrangement: tiles in order with the blank tile at the last position
        let correctOrder = (0..<tiles.count - 1).map { $0 } + [tiles.count - 1]
        let currentOrder = tiles.indices.map { $0 }

        // Check if the current arrangement matches the correct order
        if currentOrder == correctOrder && emptyIndex == tiles.count - 1 {
            isSolved = true
        }
    }

    static func setupTiles(tiles: [UIImage], gridSize: Int) -> [UIImage] {
        var setupTiles = tiles
        setupTiles.append(UIImage()) // Add the blank tile at the last position
        return setupTiles
    }
}
