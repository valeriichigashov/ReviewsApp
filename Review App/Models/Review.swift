import Foundation
import FirebaseDatabase

struct Review: Codable, Hashable, DTOObject {
    
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case date
        case isRated
        case ratingValue
    }
}

extension Review: DBConvertible {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        date = try container.decode(Date.self, forKey: .date)
        isRated = try container.decode(Bool.self, forKey: .isRated)
        ratingValue = try container.decode(Int.self, forKey: .ratingValue)
    }
    
    init(from repsesented: RepresentedType) {
        id = repsesented.id.uuidString
        title = repsesented.titleReview
        description = repsesented.descriptionReview
        date = repsesented.dateReview
        dateString = repsesented.dateString
        isRated = repsesented.isRated
        ratingValue = Int(repsesented.ratingValue)
        imageURL = repsesented.imageURL
        imageData = repsesented.imageData
    }
    
    func toDBObject() -> DBObject {
        
        ReviewDB(id: id,
                 title: title,
                 description: description,
                 date: date,
                 dateString: dateString,
                 isRated: isRated,
                 ratingValue: ratingValue,
                 imageURL: imageURL,
                 imageData: imageData)
    }
}
