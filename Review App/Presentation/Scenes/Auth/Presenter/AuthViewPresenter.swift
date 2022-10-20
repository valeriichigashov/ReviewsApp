import Foundation

enum AuthType {
    
    case signUp
    case signIn
    
    var mainTitle: String {
        switch self {
        case .signUp:
            return "Sign Up"
        case .signIn:
            return "Sign In"
        }
    }
    
    var title: String {
        switch self {
        case .signUp:
            return "Sign Up to save your reveiws in a cloud"
        case .signIn:
            return "Sign In to save your reveiws in a cloud"
        }
    }
    
    var isHaveAccount: String {
        switch self {
        case .signUp:
            return "Already have an account?"
        case .signIn:
            return "Don't have an account yet?"
        }
    }
    
    var enterButton: String {
        switch self {
        case .signUp:
            return "Sign Up"
        case .signIn:
            return "Sign In"
        }
    }
    
    var switchButton: String {
        switch self {
        case .signUp:
            return "Sign In"
        case .signIn:
            return "Sign Up"
        }
    }
}

class AuthViewPresenter {
    
    private var authService = AuthService()
    
    private var authType: AuthType = .signUp
    
    private var username = ""
    private var password = ""
    
    private var isUsernameValid = false
    private var isPasswordValid = false
    
    private weak var authViewInputDelegate: AuthViewInputDelegate?
    
    init(authViewInputDelegate: AuthViewInputDelegate) {
        self.authViewInputDelegate = authViewInputDelegate
    }
}

extension AuthViewPresenter: AuthViewOutputDelegate {
    
    func usernameDidChange(_ text: String?) {
        username = text ?? ""
        
        validateUsername()
        validateState()
    }
    
    func passwordDidChange(_ text: String?) {
        password = text ?? ""
        
        switch authType {
        case.signUp:
            validatePassword()
            validateState()
        case.signIn:
            password.isEmpty ? (isPasswordValid = false) : (isPasswordValid = true)
            validateState()
        }
    }
    
    func enterButtonTapped() {
        switch authType {
        case.signUp:
            authService.registrationNewUser(username: username, password: password, complition: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.authType = .signIn
                    self.authViewInputDelegate?.clearData()
                    self.authViewInputDelegate?.changeViewState(for: self.authType)
                    self.authViewInputDelegate?.setStateEnterButton(isEnabled: false)
                    self.isUsernameValid = false
                    self.isPasswordValid = false
                case .failure(let error):
                    self.authViewInputDelegate?.showAlert(title: "Failed to Sign Up", message: error.localizedDescription)
                }
            })
        case.signIn:
            authService.authenticationUser(username: username, password: password, complition: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.authViewInputDelegate?.showNewInterface()
                case .failure(let error):
                    self.authViewInputDelegate?.showAlert(title: "Failed to Sign In", message: error.localizedDescription)
                }
            })
        }
    }
    
    func switchAuthButtonTapped() {
        switch authType {
        case .signUp:
            authType = .signIn
        case .signIn:
            authType = .signUp
        }
        authViewInputDelegate?.clearData()
        authViewInputDelegate?.changeViewState(for: authType)
        authViewInputDelegate?.setStateEnterButton(isEnabled: false)
        isUsernameValid = false
        isPasswordValid = false
    }
    
    func laterButtonTapped() {
        authViewInputDelegate?.showNewInterface()
    }
}

private extension AuthViewPresenter {
    
    func setAuthViewInputDelegate(authViewInputDelegate: AuthViewInputDelegate?) {
        self.authViewInputDelegate = authViewInputDelegate
    }
    
    func clearData() {
        username = ""
        password = ""
    }
    
    func validateUsername() {
        if username.isEmail {
            isUsernameValid = true
            authViewInputDelegate?.showUsernameWarning(message: "")
        } else {
            isUsernameValid = false
            authViewInputDelegate?.showUsernameWarning(message: "Username not right")
        }
        if username.count == 0 {
            authViewInputDelegate?.showUsernameWarning(message: "")
        }
    }
    
    func validatePassword() {
        
        if password.isPasswordValidate {
            isPasswordValid = true
            authViewInputDelegate?.showPasswordWarning(message: "")
        } else {
            isPasswordValid = false
            authViewInputDelegate?.showPasswordWarning(message: "Password not right")
        }
        if password.count == 0 {
            authViewInputDelegate?.showPasswordWarning(message: "")
        }
    }
    
    func validateState() {
        let isButtonEnabled = isUsernameValid && isPasswordValid
        authViewInputDelegate?.setStateEnterButton(isEnabled: isButtonEnabled)
    }
}
