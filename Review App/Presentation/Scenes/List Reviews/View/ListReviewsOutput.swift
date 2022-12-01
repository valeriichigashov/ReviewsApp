import Foundation

protocol ListReviewsOutput: AnyObject {
    func viewDidLoad()
    func cellData(for indexPath: IndexPath) -> Review
    func titleForHeaderInSection(_ section: Int) -> String?
    func deleteCell(for indexPath: IndexPath)
    func toggleRating(for indexPath: IndexPath)
    func editReviewCell(_ model: Review)
}
