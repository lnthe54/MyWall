import UIKit

protocol PhotoDetailNavigator: BaseNavigator {
    
}

class DefaultPhotoDetailNavigator: PhotoDetailNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func popToViewController() {
        navigationController.popViewController(animated: true)
    }
}
