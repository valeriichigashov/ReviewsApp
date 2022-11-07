import UIKit

class NavigationController: UINavigationController {
    
    private lazy var navigateBar: UINavigationBar = {
        let navigateBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "Create a review")
        let saveItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: nil, action: #selector(saveReviewDidTapped))
        navigationItem.rightBarButtonItem = saveItem
        navigateBar.setItems([navigationItem], animated: false)
        return navigateBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navigateBar)
        setNavigationBarConstraints()
    }
}

extension NavigationController {
    
    private func setNavigationBarConstraints() {
        
        navigateBar.translatesAutoresizingMaskIntoConstraints = false
        navigateBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigateBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigateBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func saveReviewDidTapped() {

    }
}
