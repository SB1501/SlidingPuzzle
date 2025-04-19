import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var tiles: [UIImage] = []
    @State private var showingImagePicker = false
    let gridSize = 3

    var body: some View {
        VStack {
            if let image = selectedImage {
                if tiles.isEmpty {
                    Text("Generating tiles...")
                        .onAppear {
                            tiles = splitImage(image: image, gridSize: gridSize)
                            tiles.append(UIImage()) // Add blank tile
                        }
                } else {
                    PuzzleView(tiles: tiles, gridSize: gridSize)
                }
            } else {
                Button("Select Photo") {
                    showingImagePicker = true
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .onChange(of: selectedImage) { newImage in
            if let image = newImage {
                tiles = splitImage(image: image, gridSize: gridSize)
                tiles.append(UIImage()) // Add blank tile
            }
        }
    }
}
