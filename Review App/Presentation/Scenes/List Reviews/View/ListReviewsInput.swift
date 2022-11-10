import Foundation

protocol ListReviewsInput: AnyObject {
    func setSections()
    func setNewReviewCell() -> Review
    //func selectEditReviewCell()
}
