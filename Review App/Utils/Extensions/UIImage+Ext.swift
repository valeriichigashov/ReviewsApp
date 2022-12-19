import Foundation
import UIKit

extension UIImage {
    
    static func loadImage(url: URL?) -> UIImage? {
        guard let path = url else { return UIImage(systemName: "photo") }
        do {
            guard let imageData = try? Data(contentsOf: path) else { return UIImage(systemName: "photo") }
            return UIImage(data: imageData)
        }
    }
}
