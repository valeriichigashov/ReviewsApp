import UIKit

class AuthViewController: UIViewController {

    var signup: Bool = true {
        willSet {
            if newValue {
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
    }

    
    @IBAction func switchAuth(_ sender: UIButton) {
        signup = !signup
    }
}
