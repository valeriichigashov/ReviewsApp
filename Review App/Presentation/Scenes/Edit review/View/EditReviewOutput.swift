import Foundation

protocol EditReviewOutput: AnyObject {
    func reviewNameDidChange(_ text: String?)
    func reviewDescriptionDidChange(_ textView: String?)
    func ratingSliderValueDidChange(_ sliderValue: Float)
    func configureReview(with model: Review)
    func saveReviewButtonTapped()
    func imageReviewDidChange(_ image: Data?)
}
