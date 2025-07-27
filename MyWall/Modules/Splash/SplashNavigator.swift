import UIKit

protocol SplashNavigator {
    func gotoMainViewController()
}

class DefaultSplashNavigator: SplashNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoMainViewController() {
        let mainViewController = MainViewController()
        navigationController.pushViewController(mainViewController, animated: true)
    }
}


