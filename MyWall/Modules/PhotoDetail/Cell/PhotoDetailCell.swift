import UIKit
import Kingfisher

class PhotoDetailCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.corner(12)
        posterImageView.contentMode = .scaleAspectFill
    }

    func bindURL(_ url: URLElement) {
        posterImageView.kf.setImage(
            with: URL(string: url.raw ?? ""),
            placeholder: UIImage(named: "ic_loading"),
            options: [.transition(ImageTransition.fade(1))]
        )
    }
}
