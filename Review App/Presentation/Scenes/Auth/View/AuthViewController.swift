import UIKit
import Firebase

class AuthViewController: UIViewController {

    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    
    @IBOutlet weak var usernameInfoLabel: UILabel!
    @IBOutlet weak var passwordInfoLabel: UILabel!
    
    lazy var presenter: AuthViewOutputDelegate = {
        let presenter = AuthViewPresenter(authViewInputDelegate: self)
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func usernameTFDidChange(_ sender: UITextField) {
        presenter.usernameDidChange(sender.text)
    }
    
    @IBAction func passwordTFDidChange(_ sender: UITextField) {
        presenter.passwordDidChange(sender.text)
    }
    
    @IBAction func enterAuth(_ sender: UIButton) {
//        let name = usernameField.text!
//        let password = passwordField.text!
//
//        if signup {
//            if (!name.isEmpty && !password.isEmpty) {
//                Auth.auth().createUser(withEmail: name, password: password) { (result, error) in
//                    if error == nil {
//                        if let result = result {
//                            print(result.user.uid)
//                        }
//                    }
//                }
//            } else {
//                showAlert()
//            }
//        } else {
//            if (!name.isEmpty && !password.isEmpty) {
//
//            } else {
//                showAlert()
//            }
//        }
    }
    
    @IBAction func switchAuth(_ sender: UIButton) {
        presenter.changeAuthType()
    }
    
    @IBAction func laterAuth(_ sender: Any) {
    }
    
//    func showAlert() {
//        let alert = UIAlertController(title: "Error", message: "Fill filds", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
}

extension AuthViewController: AuthViewInputDelegate {
    
    func setStateEnterButton(isEnabled: Bool) {
        enterButton.isEnabled = isEnabled
    }
    
    func clearData() {
        usernameField.text = ""
        passwordField.text = ""
        usernameInfoLabel.isHidden = true
        passwordInfoLabel.isHidden = true
    }
    
    func showUsernameWarning(message: String) {
        usernameInfoLabel.alpha = 1
        usernameInfoLabel.isHidden = false
        usernameInfoLabel.text = message
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            self.usernameInfoLabel.alpha = 0.3
        })
    }
    
    func showPasswordWarning(message: String) {
        passwordInfoLabel.alpha = 1
        passwordInfoLabel.isHidden = false
        passwordInfoLabel.text = message
        UIView.animate(withDuration: 3.0, animations: { () -> Void in
            self.passwordInfoLabel.alpha = 0.3
        })
    }
    
    func changeViewState(for type: AuthType) {
        mainTitleLabel.text = type.mainTitle
        titleLabel.text = type.title
        alreadyHaveAccountLabel.text = type.isHaveAccount
        enterButton.setTitle(type.enterButton, for: .normal)
        switchButton.setTitle(type.switchButton, for: .normal)
    }
}

private extension AuthViewController {
    
    func setupUI() {
        enterButton.isEnabled = false
        usernameInfoLabel.isHidden = true
        passwordInfoLabel.isHidden = true
    }
}
