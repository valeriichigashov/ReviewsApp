import Foundation

protocol AuthViewOutput: AnyObject {
    func usernameDidChange(_ text: String?)
    func passwordDidChange(_ text: String?)
    func enterButtonTapped()
    func switchAuthButtonTapped()
    func laterButtonTapped()
}
