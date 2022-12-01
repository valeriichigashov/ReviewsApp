import Foundation
import UIKit

extension String {
    
    var isEmail: Bool {
        let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$"#
        let usernameRegex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        if usernameRegex?.firstMatch(in: self, options: [], range: range) != nil {
            return true
        } else {
            return false
        }
    }
    
    var isPasswordValidate: Bool {
        let pattern = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[@$!%*?&#])[A-Za-z0-9@$!%*?&#]{6,}$"
        let usernameRegex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        if usernameRegex?.firstMatch(in: self, options: [], range: range) != nil {
            return true
        } else {
            return false
        }
    }
}
