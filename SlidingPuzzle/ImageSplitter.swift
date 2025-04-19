import UIKit

func splitImage(image: UIImage, gridSize: Int) -> [UIImage] {
    guard let cgImage = image.cgImage else {
        return []
    }

    let width = cgImage.width / gridSize
    let height = cgImage.height / gridSize

    var tiles: [UIImage] = []

    for row in 0..<gridSize {
        for col in 0..<gridSize {
            let rect = CGRect(x: col * width, y: row * height, width: width, height: height)
            if let tileCgImage = cgImage.cropping(to: rect) {
                tiles.append(UIImage(cgImage: tileCgImage))
            }
        }
    }

    tiles.append(UIImage()) // Add a blank tile
    return tiles
}
