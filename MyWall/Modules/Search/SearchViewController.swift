import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: SearchNavigator
    private var viewModel: SearchViewModel
    private var page: Int = 1
    
    private let getDataTrigger = PublishSubject<Int>()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var searchView: UIView!
    @IBOutlet private weak var searchTf: UITextField!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    init(navigator: SearchNavigator, viewModel: SearchViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: Self.className, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataTrigger.onNext(page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postNoficaition(name: .showTabBar)
    }
    
    override func setupViews() {
        searchView.backgroundColor = .darkGray
        searchView.corner(12)
        
        searchTf.attributedPlaceholder = NSAttributedString(
            string: "Search anything...",
            attributes: [
                .foregroundColor: UIColor.lightGray
            ]
        )
        
        searchTf.tintColor = .white
    }
    
    override func bindViewModel() {
        let input = SearchViewModel.Input(getDataTrigger: getDataTrigger.asObservable())
        let output = viewModel.transform(input: input)
        
        output.getDataEvent
            .driveNext { [weak self] items in
                
            }
            .disposed(by: disposeBag)
    }
}
