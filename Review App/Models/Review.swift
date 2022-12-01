import Foundation
import UIKit

struct Review {
    
    var id: String = UUID().uuidString
    var title: String
    var desription: String
    var date: Date
    var dateString: String?
    //var image
    var isRated: Bool
    var ratingValue: Int
    
}

#if DEBUG
extension Review {
    static var testData = [
        Review(title: "Smile", desription: "Description dfdsfo sdfs sdfsdfsfs sdf", date: Date().addingTimeInterval(800000.0), isRated: true, ratingValue: 2),
        Review(title: "The Good House", desription: "Description dfd fghfghsfo sdfs sdfs fghfg gh gh fghdfsfs sdf", date: Date().addingTimeInterval(80000.0), isRated: true, ratingValue: 3),
        Review(title: "Samaritian", desription: "Description sfs sdf", date: Date().addingTimeInterval(0.0), isRated: true, ratingValue: 8),
        Review(title: "Pearl", desription: "Descript fghfg gh gh fghdfsfs sdf", date: Date().addingTimeInterval(30000.0), isRated: false, ratingValue: 0),
        Review(title: "The boys", desription: "Descrsd sd ipt fghfg gh gh fghdfsfs sdf", date: Date().addingTimeInterval(10000.0), isRated: false, ratingValue: 0),
    ]
}
#endif
