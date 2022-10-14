import FirebaseAuth
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
//        if let windowScene = scene as? UIWindowScene {
//                window = UIWindow(windowScene: windowScene)
//            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
//            let newvc = storyboard.instantiateViewController(withIdentifier: "init")
//            window?.rootViewController = newvc
//            window?.makeKeyAndVisible()
//            }
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print(error)
//        }
//        Auth.auth().signIn(withEmail: "dfsdf@sd.ru", password: "123456") { [weak self] authResult, error in
//            guard let strongSelf = self else { return }
//          }
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user == nil {
//                self.showAuthStoryboard()
//            }
//        }
    }
    
    func showAuthStoryboard() {
        
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let newvc = storyboard.instantiateViewController(withIdentifier: "signIn") as! AuthViewController
        self.window?.rootViewController?.present(newvc, animated: true)
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
    }
}

