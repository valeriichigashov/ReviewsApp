import UIKit

class EditReviewController: UIViewController {
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        let navigationItem = UINavigationItem(title: "Create a review")
        let saveItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: nil, action: #selector(saveReview))
        navigationItem.rightBarButtonItem = saveItem
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.layer.masksToBounds = false
        
        return navigationBar
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.frame.size = scrollView.contentSize
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let reviewName: UILabel = {
        let reviewName = UILabel()
        reviewName.text = "Review name"
        return reviewName
    }()
    
    private let enterName: UITextField = {
        let enterName = UITextField()
        enterName.placeholder = "Enter name"
        enterName.layer.borderWidth = 1
        return enterName
    }()
    
    private let reviewImage: UILabel = {
        let reviewImage = UILabel()
        reviewImage.text = "Review image(Optional)"
        return reviewImage
    }()
    
    private let imageButtonView: UIView = {
        let imageButtonView = UIView()
        return imageButtonView
    }()
    
    private let imageButton: UIButton = {
        let imageButton = UIButton()
        let image = UIImage(systemName: "photo")
        imageButton.setImage(image, for: .normal)
        imageButton.contentVerticalAlignment = .fill
        imageButton.contentHorizontalAlignment = .fill
        return imageButton
    }()
    
    private let review: UILabel = {
        let review = UILabel()
        review.text = "Review"
        return review
    }()
    
    private let enterReview: UITextView = {
        let enterReview = UITextView()
        enterReview.text = "Enter review text"
        enterReview.textColor = UIColor(white: 0.0, alpha: 0.5)
        enterReview.layer.borderWidth = 1
        return enterReview
    }()
    
    private let rating: UILabel = {
        let rating = UILabel()
        rating.text = "Rating(Optional)"
        return rating
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 1
        slider.addTarget(self, action: #selector(sliderValue(sender:)), for: .valueChanged)
        return slider
    }()
    
    private let ratingValue: UILabel = {
        let ratingValue = UILabel()
        ratingValue.text = "1 / 10"
        return ratingValue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        showView()
        addAllConstraints()
    }
}

extension EditReviewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == UIColor(white: 0.0, alpha: 0.5) {
            textView.text = nil
            textView.textColor = UIColor(white: 0.0, alpha: 1.0)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "Enter review text"
            textView.textColor = UIColor(white: 0.0, alpha: 0.5)
        }
    }
}

extension EditReviewController {
    
    private func setupViewConstr(){
        
    }
    
    private func setNavigationBarConstraints() {
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        navigationBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setScrollViewConstraints() {
        
        addConstraints(viewElement: scrollView)
        scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.showsHorizontalScrollIndicator = false
    }

    private func setStackViewConstraints() {

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func setEnterNameTextFieldConstraints() {
        
        addConstraints(viewElement: enterName)
        enterName.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setImageButtonViewConstraints() {
        
        addConstraints(viewElement: imageButtonView)
        imageButtonView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setImageButtonConstraints() {
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageButton.topAnchor.constraint(equalTo: imageButtonView.topAnchor).isActive = true
        imageButton.leftAnchor.constraint(equalTo: imageButtonView.leftAnchor).isActive = true
        imageButton.bottomAnchor.constraint(equalTo: imageButtonView.bottomAnchor).isActive = true
    }
    
    private func setEnterReviewTextViewConstraints() {
        
        addConstraints(viewElement: enterReview)
        enterReview.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setSliderConstraints() {
        
        addConstraints(viewElement: slider)
        slider.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setLabelConstraints(label: UILabel) {
        
        addConstraints(viewElement: label)
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func addConstraints(viewElement: UIView) {
        
        viewElement.translatesAutoresizingMaskIntoConstraints = false
        viewElement.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        viewElement.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
        
    @objc func saveReview() {
        
    }
    
    @objc func sliderValue(sender: UISlider) {
        
        ratingValue.text = "\(Int(sender.value)) / \(Int(slider.maximumValue))"
    }
    
    private func showView() {
        
        view.addSubview(navigationBar)
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(reviewName)
        stackView.addArrangedSubview(enterName)

        stackView.addArrangedSubview(reviewImage)
        stackView.addArrangedSubview(imageButtonView)
        imageButtonView.addSubview(imageButton)

        stackView.addArrangedSubview(review)
        stackView.addArrangedSubview(enterReview)

        stackView.addArrangedSubview(rating)
        stackView.addArrangedSubview(slider)
        stackView.addArrangedSubview(ratingValue)
    }
    
    private func addAllConstraints() {
        
        setNavigationBarConstraints()
        setScrollViewConstraints()
        setStackViewConstraints()
        
        setLabelConstraints(label: reviewName)
        setEnterNameTextFieldConstraints()
        
        setLabelConstraints(label: reviewImage)
        setImageButtonViewConstraints()
        setImageButtonConstraints()
        
        setLabelConstraints(label: review)
        setEnterReviewTextViewConstraints()
        
        setLabelConstraints(label: rating)
        setSliderConstraints()
        setLabelConstraints(label: ratingValue)
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        enterReview.delegate = self
    }
}
