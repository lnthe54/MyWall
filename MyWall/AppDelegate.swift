import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        FirebaseApp.configure()
        _ = RemoteConfigManager.shared
        
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
        let viewModel = SplashViewModel()
        let splashViewController = SplashViewController(navigator: navigator, viewModel: viewModel)
        navigationController.viewControllers = [splashViewController]
        
        return navigationController
    }
}
