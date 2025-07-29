import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.corner(12)
        posterImageView.contentMode = .scaleAspectFill
        
        containerView.backgroundColor = .blackColor.withAlphaComponent(0.3)
        categoryLabel.textColor = .white
        categoryLabel.font = .systemFont(ofSize: 16, weight: .bold)
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .center
    }

    func bindCategory(_ category: CategoryElement) {
        posterImageView.kf.setImage(
            with: URL(string: category.background),
            placeholder: UIImage(named: "ic_loading"),
            options: [.transition(ImageTransition.fade(1))]
        )
        categoryLabel.text = category.name
    }
}
