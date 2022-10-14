import Foundation

protocol AuthViewOutputDelegate: AnyObject {
    func changeAuthType()
    func usernameDidChange(_ text: String?)
    func passwordDidChange(_ text: String?)
    func enterButtonTapped()
    func laterButtonTapped()
}
