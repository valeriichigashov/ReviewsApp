import Foundation

protocol EditReviewInput: AnyObject {
    func setStateSaveButton(isEnabled: Bool)
    func setRatingValueLabel()
    func closeEditReviewController()
}
