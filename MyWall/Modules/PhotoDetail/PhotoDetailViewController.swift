import UIKit

class PhotoDetailViewController: BaseViewController {

    // MARK: - Properties
    private var navigator: PhotoDetailNavigator
    private var selectedIndex: Int
    private var items: [PhotoElement]
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    init(
        navigator: PhotoDetailNavigator,
        selectedIndex: Int,
        items: [PhotoElement]
    ) {
        self.navigator = navigator
        self.selectedIndex = selectedIndex
        self.items = items
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
        
        postNoficaition(name: .hideTabBar)
    }
    
    override func setupViews() {
        collectionView.configure(
            withCells: [PhotoDetailCell.self],
            dataSource: self
        )
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.alwaysBounceVertical = false
        collectionView.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: AppLayout.detailPhotoSection()), animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02, execute: {
            self.collectionView.scrollToItem(
                at: IndexPath(row: self.selectedIndex, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
        })
    }
    
    override func bindViewModel() {
        
    }
    
    @IBAction private func tapToClose() {
        navigator.popToViewController()
    }
}

extension PhotoDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoDetailCell.className, for: indexPath) as! PhotoDetailCell
        if let sourceElement = items[indexPath.row].source {
            cell.bindURL(sourceElement)
        }
        return cell
    }
}
