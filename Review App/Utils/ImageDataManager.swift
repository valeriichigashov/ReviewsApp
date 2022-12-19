import Foundation

final class ImageDataManager {
    
    static let instatnce = ImageDataManager()
    
    func documentDirectoryPath() -> URL {
        
        guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return URL(fileURLWithPath: "") }
        return path
    }
    
    func saveImage(_ imageData: Data?, _ fileName: String) -> URL? {
        
        let path = documentDirectoryPath().appendingPathComponent("Review_\(fileName).jpeg")
        if let data = imageData {
            try? data.write(to: path)
        }
        return path
    }
    
    func deleteImage(_ fileName: String) {

        let path = documentDirectoryPath().appendingPathComponent("Review_\(fileName).jpeg")
        do {
            try FileManager.default.removeItem(atPath: path.path)
        } catch {
            print(error)
        }
    }

    func clearTmpFiles() {
        
        do {
            let tmpDirectory = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
            try tmpDirectory.forEach { file in
                let path = String.init(format: "%@%@", NSTemporaryDirectory(), file)
                try FileManager.default.removeItem(atPath: path)
            }
        } catch {
            print(error)
        }
    }
    
//    func clearDocDirectFiles() {
//
//        let path = documentDirectoryPath()
//        do {
//            try FileManager.default.removeItem(atPath: path.path)
//        } catch {
//            print(error)
//        }
//    }
}
