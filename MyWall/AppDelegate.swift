import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = getViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    private func getViewController() -> UIViewController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        
        let navigator = DefaultSplashNavigator(navigationController: navigationController)
        let splashViewController = SplashViewController(navigator: navigator)
        navigationController.viewControllers = [splashViewController]
        
        return navigationController
    }
}
