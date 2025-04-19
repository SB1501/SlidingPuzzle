import UIKit

func splitImage(image: UIImage, gridSize: Int) -> [UIImage] {
    guard let cgImage = image.cgImage else {
        print("Error: Unable to get CGImage from UIImage.")
        return []
    }

    let tileWidth = cgImage.width / gridSize
    let tileHeight = cgImage.height / gridSize

    var tiles: [UIImage] = []

    for row in 0..<gridSize {
        for col in 0..<gridSize {
            let rect = CGRect(x: col * tileWidth, y: row * tileHeight, width: tileWidth, height: tileHeight)
            if let tileCgImage = cgImage.cropping(to: rect) {
                tiles.append(UIImage(cgImage: tileCgImage))
            }
        }
    }

    return tiles
}
