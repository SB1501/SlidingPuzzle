import SwiftUI

struct PuzzleView: View {
    @State var tiles: [UIImage]   // Tiles to display
    @State var gridSize: Int      // Grid size (e.g., 3x3)
    @State private var emptyIndex: Int = 0 // Index of the blank tile
    
    var body: some View {
        if tiles.isEmpty || !tiles.indices.contains(emptyIndex) {
            Text("No tiles to display")
                .foregroundColor(.gray)
        } else {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 2) {
                ForEach(tiles.indices, id: \.self) { index in
                    Image(uiImage: tiles[index])
                        .resizable()
                        .scaledToFit()
                        .opacity(index == emptyIndex ? 0 : 1) // Transparent blank tile
                        .onTapGesture {
                            if index != emptyIndex {
                                moveTile(at: index)
                            }
                        }
                }
            }
            .padding()
        }
    }

    func moveTile(at tileIndex: Int) {
        if canMove(tileIndex: tileIndex, emptyIndex: emptyIndex, gridSize: gridSize) {
            withAnimation {
                tiles.swapAt(tileIndex, emptyIndex)
                emptyIndex = tileIndex
            }
        }
    }

    func canMove(tileIndex: Int, emptyIndex: Int, gridSize: Int) -> Bool {
        let rowDiff = abs(tileIndex / gridSize - emptyIndex / gridSize)
        let colDiff = abs(tileIndex % gridSize - emptyIndex % gridSize)
        return (rowDiff + colDiff) == 1
    }
}
