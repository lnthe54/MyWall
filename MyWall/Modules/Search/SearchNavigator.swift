import UIKit

protocol SearchNavigator {
    func gotoPhotoDetail(selectedIndex: Int, items: [PhotoElement])
}

class DefaultSearchNavigator: SearchNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoPhotoDetail(selectedIndex: Int, items: [PhotoElement]) {
        let navigator = DefaultPhotoDetailNavigator(navigationController: navigationController)
        let viewController = PhotoDetailViewController(
            navigator: navigator,
            selectedIndex: selectedIndex,
            items: items
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}
