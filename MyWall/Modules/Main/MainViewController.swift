import UIKit
import RxGesture

class MainViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var tabbarView: UIStackView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var discoverView: UIView!
    @IBOutlet private weak var discoverIcon: UIImageView!
    @IBOutlet private weak var settingView: UIView!
    @IBOutlet private weak var settingIcon: UIImageView!
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchIcon: UIImageView!
    @IBOutlet private weak var favoriteView: UIView!
    @IBOutlet private weak var favoriteIcon: UIImageView!
    
    // MARK: - Properties
    private var mainViewPager: MainViewPager!
    
    init() {
        super.init(nibName: Self.className, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(hideTabbar),
            name: .hideTabBar,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showTabbar),
            name: .showTabBar,
            object: nil
        )
    }
    
    override func setupViews() {
        setupMainViewPager()
        tabbarView.backgroundColor = .blackColor
        
        discoverView.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                
                mainViewPager.moveToScreen(at: .discover)
                handleTap(isActiveDiscover: true)
            })
            .disposed(by: disposeBag)
        
        settingView.rx.tapGesture().when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                
                mainViewPager.moveToScreen(at: .setting)
                handleTap(isActiveSetting: true)
            })
            .disposed(by: disposeBag)
        
        handleTap(isActiveDiscover: true)
    }
    
    private func handleTap(
        isActiveDiscover: Bool = false,
        isActiveSearch: Bool = false,
        isActiveFavorite: Bool = false,
        isActiveSetting: Bool = false
    ) {
        // Do something with the tabbar
    }

    private func setTab(
        icon: UIImageView,
        activeImage: String,
        inactiveImage: String,
        lineView: UIView,
        isActive: Bool
    ) {
        icon.image = UIImage(named: isActive ? activeImage : inactiveImage)
        lineView.backgroundColor = isActive ? .pimaryColor : .clear
    }
    
    private func setupMainViewPager() {
        mainViewPager = MainViewPager()
        mainViewPager.view.frame = containerView.bounds
        addChild(mainViewPager)
        containerView.addSubview(mainViewPager.view)
        mainViewPager.didMove(toParent: self)
    }
}

extension MainViewController {
    @objc
    private func hideTabbar() {
        tabbarView.isHidden = true
    }
    
    @objc
    private func showTabbar() {
        tabbarView.isHidden = false
    }
}
