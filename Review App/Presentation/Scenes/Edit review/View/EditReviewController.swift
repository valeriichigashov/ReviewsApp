import UIKit

class EditReviewController: UIViewController {
    
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
    
    private let enterNameTextField: UITextField = {
        let enterNameTextField = UITextField()
        enterNameTextField.placeholder = "Enter name"
        enterNameTextField.layer.borderWidth = 1
        enterNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: enterNameTextField.frame.height))
        enterNameTextField.leftViewMode = .always
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
    
    private let imageButton: UIButton = {
        let imageButton = UIButton()
        let config = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "photo", withConfiguration: config)
        imageButton.setImage(image, for: .normal)
//        imageButton.contentMode = .scaleAspectFill
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.contentVerticalAlignment = .fill
        imageButton.contentHorizontalAlignment = .fill
        imageButton.tintColor = .black
        imageButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        imageButton.layer.borderWidth = 2
        imageButton.layer.cornerRadius = 8
        return imageButton
    }()
    
    private let reviewLabel: UILabel = {
        let reviewLabel = UILabel()
        reviewLabel.text = "Review"
        return reviewLabel
    }()
    
    private let enterReviewTextField: UITextView = {
        let enterReviewTextField = UITextView()
        enterReviewTextField.text = "Enter review text"
        enterReviewTextField.textColor = UIColor(white: 0.0, alpha: 0.5)
        enterReviewTextField.layer.borderWidth = 1
        return enterReviewTextField
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
        ratingSlider.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        return ratingSlider
    }()
    
    private let ratingValueLabel: UILabel = {
        let ratingValueLabel = UILabel()
        ratingValueLabel.text = "1 / 10"
        return ratingValueLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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

extension EditReviewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        view.endEditing(true)
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
        enterReviewTextField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ratingSlider.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func sliderValueDidChange(sender: UISlider) {
        
        ratingValueLabel.text = "\(Int(sender.value)) / \(Int(ratingSlider.maximumValue))"
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
        stackView.addArrangedSubview(enterReviewTextField)

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
        enterReviewTextField.delegate = self
        enterNameTextField.delegate = self
        
        showView()
        addAllConstraints()
        addTapGestureToHideKeyboard()
    }
}
