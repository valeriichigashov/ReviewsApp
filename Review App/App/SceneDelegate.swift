import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let data = UserDefaults.standard.bool(forKey: "laterSwitch")
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        NotificationCenter.default.addObserver(self, selector: #selector(didActivate), name: Notification.Name("UserTappedSignIn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDisactivate), name: Notification.Name("UserTappedLater"), object: nil)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil && !self.data {
                self.showAuthStoryboard()
            } else if user == nil && self.data {
                self.showListReviewsXib("Sign In", #selector(self.didTapSignIn))
            } else {
                self.showListReviewsXib("Sign Out", #selector(self.didTapSignOut))
            }
        }
    }
    
    func showAuthStoryboard() {
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        guard let authViewController = storyboard.instantiateViewController(withIdentifier: "signIn") as? AuthViewController else { return }
        let navigateController = UINavigationController(rootViewController: authViewController)
        window?.rootViewController = navigateController
        window?.makeKeyAndVisible()
    }
    
    func showListReviewsXib(_ title: String, _ selector: Selector) {
        
        let viewController = ListReviewsController(nibName: "ViewListReviews", bundle: nil)
        let navigateController = UINavigationController(rootViewController: viewController)
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
        window?.rootViewController = navigateController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        // Save changes in the application's managed object context when the application transitions to the background.
        //(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @objc func didActivate() {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                self.showAuthStoryboard()
            } else {
                self.showListReviewsXib("Sign Out", #selector(self.didTapSignOut))
            }
        }
    }
    
    @objc func didDisactivate() {
        
        self.showListReviewsXib("Sign In", #selector(self.didTapSignIn))
    }
    
    @objc func didTapSignOut() {

        do {
            try Auth.auth().signOut()
            UserDefaults.standard.setValue(false, forKey: "laterSwitch")
            CoreDataManager.instatnce.deleteAllObjects(from: ReviewDB.self)
            ImageDataManager.instatnce.clearTmpFiles()
//            ImageDataManager.instatnce.clearDocDirectFiles()
        } catch {
            print(error)
        }
    }
    
    @objc func didTapSignIn() {
       
        showAuthStoryboard()
    }
}
