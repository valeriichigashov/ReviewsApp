import Foundation


class ListReviewsPresenter {
    
    private weak var listReviewsInputDelegate: ListReviewsInput?
    
    init(listReviewsInputDelegate: ListReviewsInput) {
        self.listReviewsInputDelegate = listReviewsInputDelegate
    }
}

extension ListReviewsPresenter: ListReviewsOutput {
    
}

private extension ListReviewsPresenter {
    
}
