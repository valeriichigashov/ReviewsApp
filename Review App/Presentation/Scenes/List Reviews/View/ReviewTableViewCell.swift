import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var descriptionCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with model: Review) {
        
        titleCell.text = model.title
        descriptionCell.text = model.description
        dateCell.text = model.dateString
    }
}

private extension ReviewTableViewCell {
    
    func setupUI() {
        
        imageCell.image = UIImage(systemName: "photo")
    }
}
