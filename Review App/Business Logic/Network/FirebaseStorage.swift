import Foundation
import Firebase
import FirebaseStorage

class FirebaseStorage {
    
//    let ref = "gs://review-app-e26fb.appspot.com"
    
    var storage = Storage.storage().reference()
    
    func downloadURLFromFirebase(_ review: Review, _ completion: @escaping () -> Void) {
        
        let imageRef = storage.child("User: \(AuthService().uidUser())").child("Review_\(review.id).jpeg")
        let localURL: URL
        if review.imageData != nil {
            localURL = URL(fileURLWithPath: "")
        } else {
            localURL = ImageDataManager.instatnce.documentDirectoryPath().appendingPathComponent("Review_\(review.id).jpeg")
        }

        if AuthService().uidUser() != "" {
            let downloadTask = imageRef.write(toFile: localURL) { url, error in
                if error != nil {
//                    print(error)
                } else {
                    
                }
            }
            _ = downloadTask.observe(.progress, handler: { snapshot in
                print(snapshot)
                completion()
            })
        }
    }
    
    func uploadURLToFirebase(_ review: Review) {
        
        if AuthService().uidUser() != "" {
            let db = storage.child("User: \(AuthService().uidUser())")
            db.child("Review_\(review.id).jpeg").putFile(from: review.imageURL ?? URL(fileURLWithPath: ""))
            
        }
    }
    
    func deleteURLFromFirebase(_ reviewID: String) {
        
        let desertRef = storage.child("User: \(AuthService().uidUser())").child("Review_\(reviewID).jpeg")

        desertRef.delete { error in
            if error != nil {
                
            } else {
                
            }
        }
    }
}
