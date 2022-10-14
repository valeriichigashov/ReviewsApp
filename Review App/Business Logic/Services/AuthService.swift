import Foundation
import Firebase

class AuthService {
    
    func registrationNewUser(username: String, password: String) {
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if error == nil {
                if let result = result {
                    print(result.user.uid)
                }
            }
        }
    }
    
    func authenticationUser(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { (result, error) in
            if error == nil {
                if let result = result {
                    print(result.user.uid)
                }
            }
        }
    }
}
