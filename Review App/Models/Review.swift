import Foundation

struct Review {
    var title: String
    var desription: String
    //var date: Date
    //var image
}

#if DEBUG
extension Review {
    static var sampleData = [
        Review(title: "Smile", desription: "sdfsdf sdfsd sdf"),
    ]
}
#endif
