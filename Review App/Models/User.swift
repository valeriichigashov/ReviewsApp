import Foundation

struct User {
    var email: String
}

#if DEBUG
extension User {
    static var sampleData = [
        User(email: "ter@trg.ru"),
        User(email: "test@test.ru"),
    ]
}
#endif
