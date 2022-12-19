import Foundation
import CoreData


extension ReviewDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewDB> {
        return NSFetchRequest<ReviewDB>(entityName: "ReviewDB")
    }

    @NSManaged public var id: UUID
    @NSManaged public var titleReview: String
    @NSManaged public var descriptionReview: String
    @NSManaged public var dateReview: Date
    @NSManaged public var dateString: String?
    @NSManaged public var isRated: Bool
    @NSManaged public var ratingValue: Int16
    @NSManaged public var imageURL: URL?
    @NSManaged public var imageData: Data?
}
