import UIKit

class SplashViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: SplashNavigator
    
    init(navigator: SplashNavigator) {
        self.navigator = navigator
        super.init(nibName: Self.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.navigator.gotoMainViewController()
        }
    }
}
