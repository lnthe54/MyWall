import UIKit
import RxSwift

protocol BaseNavigator {
    func popToViewController()
}

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .blackColor
        
        bindViewModel()
        setupViews()
    }
    
    func bindViewModel() {}
    
    func setupViews() {}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension BaseViewController {
    func postNoficaition(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }
    
    func showLoadingView(isLoading: Bool) {
        if isLoading {
            LoadingView.shared.startLoading()
        } else {
            LoadingView.shared.endLoading()
        }
    }
    
    func titleHeaderSection(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        indexPath: IndexPath,
        title: String
    ) -> TitleHeaderSection {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderSection.className,
            for: indexPath
        ) as! TitleHeaderSection
        header.bindTitle(title)
        return header
    }
}
