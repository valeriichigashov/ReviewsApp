import Foundation

class EditReviewPresenter {
    
   private var reviewName = ""
    private var reviewDescription = ""
    private var ratingValue = 0
    private var editedReview: Review?
    private weak var view: EditReviewInput?
    
    init(view: EditReviewInput) {
        
        self.view = view
    }
    
}

extension EditReviewPresenter: EditReviewOutput {
    
    func configureReview(with model: Review) {
        
        editedReview = model
        reviewName = model.title
        reviewDescription = model.description
        ratingValue = model.ratingValue
    }
    
    func reviewNameDidChange(_ text: String?) {
        
        reviewName = text ?? ""
        if editedReview == nil {
            validateData()
        } else {
            validateEditingData()
        }
    }
    
    func reviewDescriptionDidChange(_ textView: String?) {
        
        reviewDescription = textView ?? ""
        if editedReview == nil {
            validateData()
        } else {
            validateEditingData()
        }
    }
    
    func ratingSliderValueDidChange(_ sliderValue: Float) {
        
        ratingValue = Int(sliderValue)
        if editedReview != nil {
            validateEditingData()
        }
        view?.setRatingValueLabel()
    }
    
    func saveReviewButtonTapped() {
        
        let review = Review(id: editedReview?.id ?? "",
                            title: reviewName,
                            description: reviewDescription,
                            date: Date(),
                            dateString: "",
                            isRated: ratingValue >= 1,
                            ratingValue: ratingValue)
        if editedReview == nil {
            CoreDataManager.instatnce.addObject(dtoObject: review)
        } else {
            CoreDataManager.instatnce.editObject(from: ReviewDB.self, dtoObject: review, to: review.id)
        }
    }
}

private extension EditReviewPresenter {
    
    func validateData() {
        
        if !reviewName.isEmpty && !reviewDescription.isEmpty {
            view?.setStateSaveButton(isEnabled: true)
        } else {
            view?.setStateSaveButton(isEnabled: false)
        }
    }
    
    func validateEditingData() {
        
        if (reviewName == editedReview?.title || reviewName == "") && (reviewDescription == editedReview?.description || reviewDescription == "") && ratingValue == editedReview?.ratingValue {
            view?.setStateSaveButton(isEnabled: false)
        } else {
            view?.setStateSaveButton(isEnabled: true)
        }
    }
}
