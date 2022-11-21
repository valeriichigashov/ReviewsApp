import Foundation
import UIKit

struct Review: DTOObject {
    
    typealias RepresentedType = ReviewDB
    
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var date: Date
    var dateString: String?
    var isRated: Bool
    var ratingValue: Int
    //var image: URL
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
    }
    
    func toDBObject() -> DBObject {
        
        ReviewDB(id: id, title: title, description: description, date: date, dateString: dateString, isRated: isRated, ratingValue: ratingValue)
    }
}

//#if DEBUG
//extension Review {
//    static var testData = [
//        Review(title: "Smile", description: "Description dfdsfo sdfs sdfsdfsfs sdf", date: Date().addingTimeInterval(800000.0), isRated: true, ratingValue: 2),
//        Review(title: "The Good House", description: "Description dfd fghfghsfo sdfs sdfs fghfg gh gh fghdfsfs sdf", date: Date().addingTimeInterval(80000.0), isRated: true, ratingValue: 3),
//        Review(title: "Samaritian", description: "Description sfs sdf", date: Date().addingTimeInterval(0.0), isRated: true, ratingValue: 8),
//        Review(title: "Pearl", description: "Descript fghfg gh gh fghdfsfs sdf", date: Date().addingTimeInterval(30000.0), isRated: false, ratingValue: 0),
//        Review(title: "The boys", description: "Descrsd sd ipt fghfg gh gh fghdfsfs sdf", date: Date().addingTimeInterval(10000.0), isRated: false, ratingValue: 0),
//    ]
//}
//#endif
