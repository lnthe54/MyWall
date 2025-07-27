import UIKit
import RxSwift
import RxCocoa

class SplashViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: SplashNavigator
    private var viewModel: SplashViewModel
    
    private let getDataTrigger = PublishSubject<Void>()
    
    init(
        navigator: SplashNavigator,
        viewModel: SplashViewModel
    ) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: Self.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataTrigger.onNext(())
    }
    
    override func setupViews() {
        
    }
    
    override func bindViewModel() {
        let input = SplashViewModel.Input(
            getDataTrigger: getDataTrigger.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .driveNext { _ in
                // Do something
            }
            .disposed(by: disposeBag)
        
        output.errorEvent
            .driveNext { _ in
                // Do something
            }
            .disposed(by: disposeBag)
        
        output.getDataEvent
            .driveNext { [weak self] _ in
                guard let self else { return }
                
                navigator.gotoMainViewController()
            }
            .disposed(by: disposeBag)
    }
}
