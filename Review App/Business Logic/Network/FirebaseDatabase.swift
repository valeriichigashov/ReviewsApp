import Foundation
import Firebase
import FirebaseDatabase

class FirebaseDatabase {
    
//    let ref = "https://review-app-e26fb-default-rtdb.firebaseio.com/"
    
    var database = Database.database().reference()
    
    func downloadObjectsFromFirebase(_ completion: @escaping ([Review]) -> Void) {
        
        var reviewsFB = [Review]()
        database.child("User: \(AuthService().uidUser())").getData(completion:  { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let object = snapshot?.value as? [String: [String: Any]] else {
                completion(reviewsFB)
                return
            }
            for dictionary in object.values {
                if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [.prettyPrinted]) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    if let reviewFB = try? decoder.decode(Review.self, from: jsonData) {
                        reviewsFB.append(reviewFB)
                    }
                }
            }
            completion(reviewsFB)
        })
    }
    
    func mergeCoreDataAndFirebase(_ reviewsFromCoreData: [Review], _ completion: @escaping () -> Void) {
        
        downloadObjectsFromFirebase() { reviewsFromFirebase in
            var reviewsFB = Set(reviewsFromFirebase)
            var reviewsDB = Set(reviewsFromCoreData)
            var fullArray = Set<Review>()
            if reviewsDB.count != 0 {
                for reviewDB in reviewsDB {
                    
                    if reviewsFB.count != 0 {
                        for reviewFB in reviewsFB {
                            if reviewDB.id == reviewFB.id {
                                if reviewDB.date >= reviewFB.date {
                                    reviewsFB.remove(reviewFB)
                                } else {
                                    reviewsDB.remove(reviewDB)
                                    let ref = self.database.child("User: \(AuthService().uidUser())")
                                    ref.child("Review: \(reviewDB.id)").updateChildValues(["id": reviewDB.id,
                                                                                           "title": reviewDB.title,
                                                                                           "description": reviewDB.description,
                                                                                           "date": reviewDB.date.timeIntervalSince1970,
                                                                                           "isRated": reviewDB.isRated,
                                                                                           "ratingValue": reviewDB.ratingValue])
                                }
                            }
                        }
                    } else {
                        fullArray = reviewsDB
                    }
                }
            } else {
                fullArray = reviewsFB
            }
            fullArray = reviewsFB.union(reviewsDB)
            for var review in fullArray {
                review.imageURL = ImageDataManager.instatnce.documentDirectoryPath().appendingPathComponent("Review_\(review.id).jpeg")
                FirebaseStorage().uploadURLToFirebase(review)
                FirebaseStorage().downloadURLFromFirebase(review) {
                    CoreDataManager.instatnce.addObject(from: ReviewDB.self, dtoObject: review)
                }
                self.uploadCoreDataToFirebase(fullArray)
            }
            completion()
        }
    }
    
    func uploadCoreDataToFirebase(_ reviews: Set<Review>) {
        
        for review in reviews {
            if AuthService().uidUser() != "" {
                let ref = database.child("User: \(AuthService().uidUser())")
                ref.child("Review: \(review.id)").setValue(["id": review.id,
                                                            "title": review.title,
                                                            "description": review.description,
                                                            "date": review.date.timeIntervalSince1970,
                                                            "isRated": review.isRated,
                                                            "ratingValue": review.ratingValue])
            }
        }
    }
    
    func deleteObjectFromFirebase(_ reviewID: String) {
        
        if AuthService().uidUser() != "" {
            let ref = database.child("User: \(AuthService().uidUser())")
            ref.child("Review: \(reviewID)").removeValue()
        }
        FirebaseStorage().deleteURLFromFirebase(reviewID)
    }
}
