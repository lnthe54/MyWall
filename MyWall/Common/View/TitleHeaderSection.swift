import UIKit

class TitleHeaderSection: UICollectionReusableView {
    // MARK: - IBOutlets
    @IBOutlet private weak var titleSection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleSection.textColor = .white
        titleSection.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func bindTitle(_ title: String) {
        titleSection.text = title
    }
}
