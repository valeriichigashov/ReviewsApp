import Foundation

protocol ListReviewsInput: AnyObject {
    func setSections(_ model: [Section])
    func startAnimatingActiveIndicator()
    func stopAnimatingActiveIndicator()
    func setStateLeftBarButtonItem(isEnabled: Bool)
}
