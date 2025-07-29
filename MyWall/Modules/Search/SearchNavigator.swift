import UIKit

protocol SearchNavigator {
    
}

class DefaultSearchNavigator: SearchNavigator {
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
