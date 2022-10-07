import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    }
    
    @IBAction func alreadyHaveAccountSignInTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signIn")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    @IBAction func laterTapped(_ sender: Any) {
    }
}
