import Foundation

protocol AuthViewInput: AnyObject {
    func showAlert(title: String, message: String)
    func showNewInterface()
    func setStateEnterButton(isEnabled: Bool)
    func clearData()
    func changeViewState(for type: AuthType)
    func showUsernameWarning(message: String)
    func showPasswordWarning(message: String)
}
