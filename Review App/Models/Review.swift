import Foundation
import UIKit

struct Review: Hashable, DTOObject {
    
    typealias RepresentedType = ReviewDB
    
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var date: Date
    var dateString: String?
    var isRated: Bool
    var ratingValue: Int
    var imageURL: URL?
    var imageData: Data?
}

extension Review: DBConvertible {
    
    init(from repsesented: RepresentedType) {
        id = repsesented.id.uuidString
        title = repsesented.titleReview
        description = repsesented.descriptionReview
        date = repsesented.dateReview
        dateString = repsesented.dateString
        isRated = repsesented.isRated
        ratingValue = Int(repsesented.ratingValue)
        imageURL = repsesented.imageURL
    }
    
    func toDBObject() -> DBObject {
        
        ReviewDB(id: id, title: title, description: description, date: date, dateString: dateString, isRated: isRated, ratingValue: ratingValue, imageURL: imageURL)
    }
}
