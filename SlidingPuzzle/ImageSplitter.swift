import UIKit

func splitImage(image: UIImage, gridSize: Int) -> [UIImage] {
    guard let cgImage = image.cgImage else {
        print("Error: Unable to get CGImage from UIImage.")
        return []
    }

    let width = cgImage.width / gridSize
    let height = cgImage.height / gridSize
    guard width > 0, height > 0 else {
        print("Error: Invalid grid size or image dimensions.")
        return []
    }

    var tiles: [UIImage] = []

    for row in 0..<gridSize {
        for col in 0..<gridSize {
            let rect = CGRect(x: col * width, y: row * height, width: width, height: height)
            if let tileCgImage = cgImage.cropping(to: rect) {
                tiles.append(UIImage(cgImage: tileCgImage))
            } else {
                print("Error: Failed to crop image at row \(row), col \(col).")
            }
        }
    }

    return tiles
}
