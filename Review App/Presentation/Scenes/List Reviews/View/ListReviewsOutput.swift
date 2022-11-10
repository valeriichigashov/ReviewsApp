import Foundation

protocol ListReviewsOutput: AnyObject {
    func viewDidLoad()
    func numberOfRowsInSection(_ section: Int) -> Int
    func titleForHeaderInSection(_ section: Int) -> String?
    func cellData(for indexPath: IndexPath) -> Review
    func numberOfSections() -> Int
    func deleteCell(for indexPath: IndexPath)
    func toggleRating(for indexPath: IndexPath)
    func addReviewCell()
    func editReviewCell(for indexPath: IndexPath)
}
