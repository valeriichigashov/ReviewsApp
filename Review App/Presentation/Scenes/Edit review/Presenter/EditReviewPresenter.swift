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
                            isRated: ratingValue >= 1,
                            ratingValue: ratingValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        review.dateString = dateFormatter.string(from: review.date)
        review.imageData = imageReviewData
        if review.imageData != nil {
            review.imageURL = ImageDataManager.instatnce.saveImage(imageReviewData, review.id)
        } else {
            review.imageURL = nil
        }
        
        CoreDataManager.instatnce.addObject(from: ReviewDB.self, dtoObject: review)
        
        if AuthService().uidUser() != "" {
            let ref = FirebaseDatabase().database.child("User: \(AuthService().uidUser())")
            ref.child("Review: \(review.id)").setValue(["id": review.id,
                                                        "title": review.title,
                                                        "description": review.description,
                                                        "date": review.date.timeIntervalSince1970,
                                                        "isRated": review.isRated,
                                                        "ratingValue": review.ratingValue])
            let db = FirebaseStorage().storage.child("User: \(AuthService().uidUser())")
            db.child("Review_\(review.id).jpeg").putFile(from: review.imageURL ?? URL(fileURLWithPath: ""))
        }
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
            && imageReviewData == editedReview?.imageData
            || (reviewName == "" || reviewDescription == "") {
            view?.setStateSaveButton(isEnabled: false)
        } else {
            view?.setStateSaveButton(isEnabled: true)
        }
    }
}
