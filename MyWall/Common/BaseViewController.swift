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
}
