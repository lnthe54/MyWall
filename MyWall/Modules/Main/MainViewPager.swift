import UIKit

enum MainTabbarTag: Int {
    case discover
    case search
    case favorite
    case setting
}

class MainViewPager: UIPageViewController {

    // MARK: - Properties
    private var discoverNavigationController: UINavigationController!
    private var searchNavigationController: UINavigationController!
    private var favoriteNavigationController: UINavigationController!
    private var settingNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    
    // MARK: - Private functions
    private func setupViewControllers() {
        createDiscoverTab()
        createSearchTab()
        createFavoriteTab()
        createSettingTab()
        
        setViewControllers([discoverNavigationController], direction: .forward, animated: false)
    }
    
    func moveToScreen(at index: MainTabbarTag) {
        var selectedViewController: UIViewController!
        
        switch index {
        case .discover:
            selectedViewController = discoverNavigationController
        case .search:
            selectedViewController = searchNavigationController
        case .favorite:
            selectedViewController = favoriteNavigationController
        case .setting:
            selectedViewController = settingNavigationController
        }
        
        setViewControllers([selectedViewController], direction: .forward, animated: false)
    }
}

extension MainViewPager {
    func createDiscoverTab() {
        discoverNavigationController = UINavigationController()
        let navigator = DefaultDiscoverNavigator(navigationController: discoverNavigationController)
        let viewModel = DiscoverViewModel()
        let viewController = DiscoverViewController(navigator: navigator, viewModel: viewModel)
        discoverNavigationController.pushViewController(viewController, animated: true)
    }
    
    func createSearchTab() {
        searchNavigationController = UINavigationController()
        let viewController = UIViewController()
        searchNavigationController.pushViewController(viewController, animated: true)
    }
    
    func createFavoriteTab() {
        favoriteNavigationController = UINavigationController()
        let viewController = UIViewController()
        favoriteNavigationController.pushViewController(viewController, animated: true)
    }
    
    func createSettingTab() {
        settingNavigationController = UINavigationController()
        let viewController = UIViewController()
        settingNavigationController.pushViewController(viewController, animated: true)
    }
}
