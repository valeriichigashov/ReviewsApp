import Foundation

protocol AuthViewInputDelegate: AnyObject {
    func setStateEnterButton(isEnabled: Bool)
    func clearData()
    func changeViewState(for type: AuthType)
    func showUsernameWarning(message: String)
    func showPasswordWarning(message: String)
}
