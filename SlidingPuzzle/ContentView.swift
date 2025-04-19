import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage? // Image chosen by the user
    @State private var tiles: [UIImage] = []  // Generated tiles
    @State private var showingImagePicker = false // Image picker toggle
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                PuzzleView(tiles: tiles, gridSize: 3) // Pass tiles to PuzzleView
                    .onAppear {
                        if tiles.isEmpty {
                            tiles = splitImage(image: image, gridSize: 3)
                        }
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
                tiles = splitImage(image: image, gridSize: 3)
            }
        }
    }
}
