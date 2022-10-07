import UIKit

class AuthViewController: UIViewController {

    
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpSubView: UIView!
    @IBOutlet weak var signInSubView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func signInTapped(_ sender: Any) {
        if (signUpView.isHidden == true) {
            signUpView.isHidden = false
            signUpSubView.isHidden = false
            signInSubView.isHidden = true
        } else {
            signUpView.isHidden = true
            signUpSubView.isHidden = true
            signInSubView.isHidden = false
        }
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if (signUpView.isHidden == true) {
            signUpView.isHidden = false
            signUpSubView.isHidden = false
            signInSubView.isHidden = true
        } else {
            signUpView.isHidden = true
            signUpSubView.isHidden = true
            signInSubView.isHidden = false
        }
    }
}
