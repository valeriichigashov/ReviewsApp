import UIKit
import Firebase

class AuthViewController: UIViewController {

    
    private let presenter = AuthViewPresenter()
    weak private var authViewOutputDelegate: AuthViewOutputDelegate?
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alreadyHaveAccountLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var laterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setAuthViewInputDelegate(authViewInputDelegate: self)
        self.authViewOutputDelegate = presenter
        self.authViewOutputDelegate?.changeAuthType()
    }

    
    @IBAction func inputUserName(_ sender: Any) {
        let name = usernameField.text!
        if !name.isEmpty {
            enterButton.isEnabled = true
        } else {
            enterButton.isEnabled = false
        }
    }
    
    @IBAction func inputPassword(_ sender: Any) {
        let password = passwordField.text!
        if !password.isEmpty {
            enterButton.isEnabled = true
        } else {
            enterButton.isEnabled = false
        }
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
        self.authViewOutputDelegate?.changeAuthType()
    }
    
    @IBAction func laterAuth(_ sender: Any) {
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill filds", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension AuthViewController: AuthViewInputDelegate {
    func changeDisplayView(authType: Bool = true) {
        
        if authType {
            mainTitleLabel.text = "Sign Up"
            titleLabel.text = "Sign Up to save your reweiws in a cloud"
            alreadyHaveAccountLabel.text = "Already have an account?"
            enterButton.setTitle("Sign Up", for: .normal)
            switchButton.setTitle("Sign In", for: .normal)
        } else {
            mainTitleLabel.text = "Sign In"
            titleLabel.text = "Sign In to save your reweiws in a cloud"
            alreadyHaveAccountLabel.text = "Don't have an account yet?"
            enterButton.setTitle("Sign In", for: .normal)
            switchButton.setTitle("Sign Up", for: .normal)
        }
    }
}
