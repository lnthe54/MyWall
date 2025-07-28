import UIKit

class DiscoverViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: DiscoverNavigator
    private var viewModel: DiscoverViewModel
    
    init(
        navigator: DiscoverNavigator,
        viewModel: DiscoverViewModel
    ) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: Self.className, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postNoficaition(name: .showTabBar)
    }
    
    override func setupViews() {
        
    }
    
    override func bindViewModel() {
        
    }
}
