import Foundation

class AuthViewPresenter {
    
    var authType = true
    
    weak private var authViewInputDelegate: AuthViewInputDelegate?
    
    func setAuthViewInputDelegate(authViewInputDelegate: AuthViewInputDelegate?) {
        self.authViewInputDelegate = authViewInputDelegate
    }
    
    
   func switchAuthType() {
        self.authViewInputDelegate?.changeDisplayView(authType: authType)
        authType.toggle()
    }
    
}

extension AuthViewPresenter: AuthViewOutputDelegate {
    func changeAuthType() {
        switchAuthType()
    }
}
