import Foundation
import CoreData

@objc(ReviewDB)
public class ReviewDB: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instatnce.entityForName(entityName: "ReviewDB"), insertInto: CoreDataManager.instatnce.context)
    }
    
    convenience init(id: String,
                     title: String,
                     description: String ,
                     date: Date,
                     dateString: String?,
                     isRated: Bool,
                     ratingValue: Int,
                     imageURL: URL?) {

        self.init()
        self.id = UUID(uuidString: id) ?? UUID()
        self.titleReview = title
        self.descriptionReview = description
        self.dateReview = date
        self.dateString = dateString
        self.isRated = isRated
        self.ratingValue = Int16(ratingValue)
        self.imageURL = imageURL
    }
}

extension ReviewDB: DBObject {
    
    
    var uuid: String {
        
        return id.uuidString
    }
    
    
    func toDTOObject() -> DTOObject {
        
        return Review(from: self)
    }
}
