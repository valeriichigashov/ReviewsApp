import Foundation
import Firebase

class AuthService {
    
    var isSignIn: Bool = false
    
    func registrationNewUser(username: String, password: String, complition: @escaping ((Result<User, Error>) -> Void)) {
        Auth.auth().createUser(withEmail: username, password: password) { (result, error) in
            if let result = result {
                self.isSignIn = true
                print(result.user.uid)
                complition(.success(User(email: result.user.email ?? "")))
            } else if let error = error {
                complition(.failure(error))
            }
        }
    }
    
    func authenticationUser(username: String, password: String, complition: @escaping ((Result<User, Error>) -> Void)) {
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] result, error  in
            if let result = result {
                self?.isSignIn = true
                print(result.user.uid)
                complition(.success(User(email: result.user.email ?? "")))
            } else if let error = error {
                complition(.failure(error))
            }
        }
    }
}
