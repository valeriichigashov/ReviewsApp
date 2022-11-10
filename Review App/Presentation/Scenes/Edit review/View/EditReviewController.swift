import UIKit

class EditReviewController: UIViewController {
    
    private lazy var barButtonItem: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.save, target: self, action: #selector(didTapSaveReview))
    }()

    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.rightBarButtonItem = barButtonItem
        item.title = "Create a review"
        return item
    }
    
    private lazy var presenter: EditReviewOutput = {
        let presenter = EditReviewPresenter(view: self)
        return presenter
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
        stackView.spacing = 30
        return stackView
    }()
    
    private let reviewNameLabel: UILabel = {
        let reviewNameLabel = UILabel()
        reviewNameLabel.text = "Review name"
        return reviewNameLabel
    }()
    
    private lazy var enterNameTextField: UITextField = {
        let enterNameTextField = UITextField()
        enterNameTextField.placeholder = "Enter name"
        enterNameTextField.layer.borderWidth = 1
        enterNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: enterNameTextField.frame.height))
        enterNameTextField.leftViewMode = .always
        enterNameTextField.addTarget(self, action: #selector(didChangeReviewName(sender:)), for: .editingChanged)
        return enterNameTextField
    }()
    
    private let reviewImageLabel: UILabel = {
        let reviewImageLabel = UILabel()
        reviewImageLabel.text = "Review image(Optional)"
        return reviewImageLabel
    }()
    
    private let imageButtonView: UIView = {
        let imageButtonView = UIView()
        return imageButtonView
    }()
    
    private lazy var imageButton: UIButton = {
        let imageButton = UIButton()
        let config = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "photo", withConfiguration: config)
        imageButton.setImage(image, for: .normal)
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.contentVerticalAlignment = .fill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.tintColor = .black
        imageButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        imageButton.layer.borderWidth = 2
        imageButton.layer.cornerRadius = 8
        imageButton.addTarget(self, action: #selector(didTapImageButton(sender:)), for: .touchUpInside)
        return imageButton
    }()
    
    private let reviewLabel: UILabel = {
        let reviewLabel = UILabel()
        reviewLabel.text = "Review"
        return reviewLabel
    }()
    
    private let enterReviewTextView: UITextView = {
        let enterReviewTextView = UITextView()
        enterReviewTextView.text = "Enter review text"
        enterReviewTextView.textColor = UIColor(white: 0.0, alpha: 0.5)
        enterReviewTextView.layer.borderWidth = 1
        return enterReviewTextView
    }()
    
    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.text = "Rating(Optional)"
        return ratingLabel
    }()
    
    private lazy var ratingSlider: UISlider = {
        let ratingSlider = UISlider()
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 10
        ratingSlider.value = 1
        ratingSlider.tintColor = .black
        ratingSlider.thumbTintColor = .black
        ratingSlider.addTarget(self, action: #selector(didChangeSliderValue(sender:)), for: .valueChanged)
        return ratingSlider
    }()
    
    private let ratingValueLabel: UILabel = {
        let ratingValueLabel = UILabel()
        ratingValueLabel.text = "1 / 10"
        return ratingValueLabel
    }()
    
    private var reviewTitle = ""
    private var reviewDescription = ""
    private var rating: Bool = false
    private var date = Date()
    
    var updatingReviewTitle = ""
    var updatingReviewDescription = "Enter review text"
    var updatingRatingValue = 1
    var updatingRatingValueLabel = "1 / 10"
    
    private lazy var review = Review(title: reviewTitle, desription: reviewDescription, date: date, isRated: rating, ratingValue: Int(ratingSlider.value))
    
    var complitionHandler: ((Review) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateData(withText: updatingReviewTitle, withText: updatingReviewDescription, withRating: updatingRatingValue, withText: updatingRatingValueLabel)
    }
}

extension EditReviewController: EditReviewInput {
    
    
}

extension EditReviewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageButton.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditReviewController: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
    }
}

extension EditReviewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        reviewDescription = textView.text
        validateData()
        validateUpdatingData()
    }
    
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
            barButtonItem.isEnabled = false
        }
    }
}

private extension EditReviewController {
    
    func setScrollViewConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setStackViewConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func setImageButtonConstraints() {
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageButton.topAnchor.constraint(equalTo: imageButtonView.topAnchor).isActive = true
        imageButton.leftAnchor.constraint(equalTo: imageButtonView.leftAnchor).isActive = true
        imageButton.bottomAnchor.constraint(equalTo: imageButtonView.bottomAnchor).isActive = true
    }
    
    func setConstraints() {
        enterNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageButtonView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        enterReviewTextView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ratingSlider.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func didChangeReviewName(sender: UITextField) {
        
        reviewTitle = sender.text ?? ""
        validateData()
        validateUpdatingData()
    }
    
    @objc func didChangeSliderValue(sender: UISlider) {
        
        ratingValueLabel.text = "\(Int(sender.value)) / \(Int(ratingSlider.maximumValue))"
        validateUpdatingData()
    }
    
    @objc func didTapImageButton(sender: UIButton) {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @objc func didTapSaveReview() {
        
        ratingSlider.value >= 1 ? (rating = true) : (rating = false)
        complitionHandler?(review)
        activeIndicator()
        navigationController?.popViewController(animated: true)
    }
    
    func addTapGestureToHideKeyboard() {
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func showView() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(reviewNameLabel)
        stackView.addArrangedSubview(enterNameTextField)
        
        stackView.addArrangedSubview(reviewImageLabel)
        stackView.addArrangedSubview(imageButtonView)
        imageButtonView.addSubview(imageButton)
        
        stackView.addArrangedSubview(reviewLabel)
        stackView.addArrangedSubview(enterReviewTextView)
        
        stackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(ratingSlider)
        stackView.addArrangedSubview(ratingValueLabel)
        
        stackView.setCustomSpacing(5, after: reviewNameLabel)
        stackView.setCustomSpacing(5, after: reviewImageLabel)
        stackView.setCustomSpacing(5, after: reviewLabel)
        stackView.setCustomSpacing(5, after: ratingLabel)
        stackView.setCustomSpacing(5, after: ratingSlider)
    }
    
    func addAllConstraints() {
        
        setScrollViewConstraints()
        setStackViewConstraints()
        setConstraints()
        setImageButtonConstraints()
    }
    
    func setupUI() {
        
        view.backgroundColor = .white
        enterReviewTextView.delegate = self
        enterNameTextField.delegate = self
        barButtonItem.isEnabled = false
        
        showView()
        addAllConstraints()
        addTapGestureToHideKeyboard()
    }
    
    func validateData() {
        
        if !reviewTitle.isEmpty && !reviewDescription.isEmpty {
            barButtonItem.isEnabled = true
        } else {
            barButtonItem.isEnabled = false
        }
    }
    
    func validateUpdatingData() {
        
        if updatingReviewTitle != enterNameTextField.text || updatingReviewDescription != enterReviewTextView.text || updatingRatingValue != Int(ratingSlider.value) {
            barButtonItem.isEnabled = true
            reviewTitle = enterNameTextField.text ?? ""
            reviewDescription = enterReviewTextView.text
            ratingSlider.value = ratingSlider.value
        } else {
            barButtonItem.isEnabled = false
        }
    }
    
    func updateData(withText name: String, withText description: String, withRating rating: Int, withText ratingValue: String) {
        
        enterNameTextField.text = name
        enterReviewTextView.text = description
        if enterReviewTextView.text == "Enter review text" {
            enterReviewTextView.textColor = UIColor(white: 0.0, alpha: 0.5)
        } else {
            enterReviewTextView.textColor = UIColor(white: 0.0, alpha: 1.0)
        }
        
        ratingSlider.value = Float(rating)
        ratingValueLabel.text = "\(Int(rating)) / \(Int(ratingSlider.maximumValue))"
    }
    
    func activeIndicator() {
        let activeIndicator = UIActivityIndicatorView(style: .medium)
        activeIndicator.center = self.view.center
        stackView.addArrangedSubview(activeIndicator)
        
        activeIndicator.startAnimating()
    }
}
