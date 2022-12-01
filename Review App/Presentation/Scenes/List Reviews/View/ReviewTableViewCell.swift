import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imageCell: UIImageView!
    @IBOutlet private weak var titleCell: UILabel!
    @IBOutlet private weak var descriptionCell: UILabel!
    @IBOutlet private weak var dateCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Review) {
        
//        print(NSHomeDirectory())
        titleCell.text = model.title
        descriptionCell.text = model.description
        dateCell.text = model.dateString
        imageCell.image = UIImage.loadImage(url: model.imageURL)
    }
}
