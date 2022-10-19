import Foundation
import Firebase

class AuthService {
    
    var isSignIn: Bool = false
    
    func registrationNewUser(username: String, password: String, complition: @escaping (() -> Void)) {
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if error == nil {
                if let result = result {
                    self.isSignIn = true
                    print(result.user.uid)
                }
            }
            complition()
        }
    }
    
    func authenticationUser(username: String, password: String, complition: @escaping (() -> Void)) {
        Auth.auth().signIn(withEmail: username, password: password) { result, error in
            if error == nil {
                if let result = result {
                    self.isSignIn = true
                    print(result.user.uid)
                }
            }
            complition()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isSignIn = false
        } catch {
            print(error)
        }
    }
}
