import UIKit
import RxSwift
import RxCocoa
import CHTCollectionViewWaterfallLayout

class SearchViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: SearchNavigator
    private var viewModel: SearchViewModel
    private var page: Int = 1
    private var photos: [PhotoElement] = []
    
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
        
        collectionView.configure(
            withCells: [PhotoCell.self],
            delegate: self,
            dataSource: self,
            contentInset: UIEdgeInsets(top: 0, left: 5, bottom: Constants.BOTTOM_TABBAR, right: 5)
        )
        
        let layout = CHTCollectionViewWaterfallLayout()
        
        layout.minimumColumnSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = layout
    }
    
    override func bindViewModel() {
        let input = SearchViewModel.Input(getDataTrigger: getDataTrigger.asObservable())
        let output = viewModel.transform(input: input)
        
        output.getDataEvent
            .driveNext { [weak self] photos in
                guard let self else { return }
                
                if page == 1 {
                    self.photos.removeAll()
                }
                
                if photos.isNotEmpty {
                    self.photos.append(contentsOf: photos)
                    page += 1
                }
                
                collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewController: UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCell.className,
            for: indexPath
        ) as! PhotoCell
        
        if let sourceElement = photos[safe: indexPath.row]?.source {
            cell.bindURL(sourceElement)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = photos[safe: indexPath.row]?.width ?? 0
        let height = photos[safe: indexPath.row]?.height ?? 0
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == photos.count - 1 {
            getDataTrigger.onNext(page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigator.gotoPhotoDetail(selectedIndex: indexPath.row, items: photos)
    }
}
