import UIKit
import RxSwift
import RxCocoa

enum DiscoverSectionType {
    case trending
    case category
}

class DiscoverViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: DiscoverNavigator
    private var viewModel: DiscoverViewModel
    private var discoverData: DiscoverData = .empty()
    private var categories: [CategoryElement] = []
    
    private let getDataTrigger = PublishSubject<Void>()
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
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
        
        categories = RemoteConfigManager.shared.getCategories()
        getDataTrigger.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        postNoficaition(name: .showTabBar)
    }
    
    override func setupViews() {
        collectionView.configure(
            withCells: [PhotoCell.self, CategoryCell.self],
            headers: [TitleHeaderSection.self],
            delegate: self,
            dataSource: self,
            contentInset: UIEdgeInsets(top: 0, left: 0, bottom: Constants.BOTTOM_TABBAR, right: 0)
        )
        configureCompositionalLayout()
    }
    
    override func bindViewModel() {
        let input = DiscoverViewModel.Input(
            getDataTrigger: getDataTrigger.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.loadingEvent
            .driveNext { [weak self] isLoading in
                self?.showLoadingView(isLoading: isLoading)
            }
            .disposed(by: disposeBag)
        
        output.errorEvent
            .driveNext { error in
                print("ERROR: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
        
        output.getDataEvent
            .driveNext { [weak self] discoverData in
                guard let self else { return }
                
                self.discoverData = discoverData
                collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

extension DiscoverViewController {
    private func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) in
            guard let self = self else { return AppLayout.defaultSection() }
            let section = self.getSections()[sectionIndex]
            
            switch section {
            case .trending:
                return AppLayout.horizontalSection()
            case .category:
                return AppLayout.categorySection()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func getSections() -> [DiscoverSectionType] {
        var sections: [DiscoverSectionType] = []
        
        if discoverData.trendingItems.isNotEmpty {
            sections.append(.trending)
        }
        
        if categories.isNotEmpty {
            sections.append(.category)
        }
        
        return sections
    }
}

extension DiscoverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return getSections().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch getSections()[section] {
        case .trending:
            return discoverData.trendingItems.count
        case .category:
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch getSections()[indexPath.section] {
        case .trending:
            return photoCell(collectionView, cellForItemAt: indexPath)
        case .category:
            return categoryCell(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == "Header" else {
            return UICollectionReusableView()
        }

        let sectionType = getSections()[indexPath.section]
        
        let title: String = {
            switch sectionType {
            case .trending:
                return "Trending"
            case .category:
                return "Categories"
            default:
                return ""
            }
        }()
        
        guard !title.isEmpty else { return UICollectionReusableView() }

        return titleHeaderSection(
            collectionView,
            viewForSupplementaryElementOfKind: kind,
            indexPath: indexPath,
            title: title
        )
    }
    
    private func photoCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> PhotoCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.className, for: indexPath) as! PhotoCell
        if let sourceElement = discoverData.trendingItems[indexPath.row].source {
            cell.bindURL(sourceElement)
        }
        return cell
    }
    
    private func categoryCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CategoryCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.className, for: indexPath) as! CategoryCell
        cell.bindCategory(categories[indexPath.row])
        return cell
    }
}

extension DiscoverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch getSections()[indexPath.section] {
        case .trending:
            navigator.gotoPhotoDetail(selectedIndex: indexPath.row, items: discoverData.trendingItems)
        case .category:
            break
        }
    }
}
