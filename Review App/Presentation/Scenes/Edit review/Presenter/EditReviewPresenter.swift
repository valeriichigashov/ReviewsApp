import Foundation

class EditReviewPresenter {
    
    private var reviewName = ""
    private var reviewDescription = ""
    private var imageReviewData: Data?
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
        validateData()
        if editedReview != nil {
            validateEditingData()
            validateData()
        }
    }
    
    func imageReviewDidChange(_ image: Data?) {
        
        imageReviewData = image
        if editedReview != nil {
            validateEditingData()
        }
    }
    
    func reviewDescriptionDidChange(_ textView: String?) {
        
        reviewDescription = textView ?? ""
        validateData()
        if editedReview != nil {
            validateEditingData()
            validateData()
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
        
        var review = Review(id: editedReview?.id ?? UUID().uuidString,
                            title: reviewName,
                            description: reviewDescription,
                            date: Date(),
                            dateString: "",
                            isRated: ratingValue >= 1,
                            ratingValue: ratingValue)
        review.imageURL = ImageDataManager.instatnce.saveImage(imageReviewData, review.id, review.imageURL?.pathExtension ?? "")
        review.imageData = imageReviewData
        CoreDataManager.instatnce.addObject(from: ReviewDB.self, dtoObject: review)
        view?.closeEditReviewController()
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
        
        if reviewName == editedReview?.title
            && reviewDescription == editedReview?.description
            && ratingValue == editedReview?.ratingValue
            && imageReviewData == editedReview?.imageData {
            view?.setStateSaveButton(isEnabled: false)
        } else {
            view?.setStateSaveButton(isEnabled: true)
        }
    }
}
