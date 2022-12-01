import Foundation

final class ImageDataManager {
    
    static let instatnce = ImageDataManager()
    
    private func documentDirectoryPath() -> URL {
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return URL(fileURLWithPath: "") }
        return path
    }
    
    func saveImage(_ imageData: Data?, _ fileName: String, _ pathExtension: String) -> URL? {
        
        let path = documentDirectoryPath().appendingPathComponent("\(fileName)\(pathExtension)")
        if let data = imageData {
            try? data.write(to: path)
        }
        return path
    }
}
