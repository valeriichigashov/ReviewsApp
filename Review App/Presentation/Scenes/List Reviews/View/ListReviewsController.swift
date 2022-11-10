import UIKit

class ListReviewsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var review = Review(title: "", desription: "", date: Date(), isRated: false, ratingValue: 0)
    private lazy var barButtonItem: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(didTapAddReview))
    }()

    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.rightBarButtonItem = barButtonItem
        item.title = "Reviews"
        return item
    }
    
    lazy var presenter: ListReviewsOutput = {
        let presenter = ListReviewsPresenter(view: self)
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension ListReviewsController: ListReviewsInput {
    
    func setSections() {
        
        tableView.reloadData()
    }
    
    func setNewReviewCell() -> Review {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        dateFormatter.dateStyle = .medium
        review.dateString = dateFormatter.string(from: review.date)
        return review
    }
}

extension ListReviewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let editReviewController = EditReviewController()
        
        editReviewController.updatingReviewTitle = presenter.cellData(for: indexPath).title
        editReviewController.updatingReviewDescription = presenter.cellData(for: indexPath).desription
        editReviewController.updatingRatingValue = presenter.cellData(for: indexPath).ratingValue
        
        editReviewController.complitionHandler = { [weak self] review in
            self?.review = review
            self?.presenter.editReviewCell(for: indexPath)
        }
        navigationController?.pushViewController(editReviewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let toggle = UIContextualAction(style: .normal, title: nil) {(_, _, complitionHand) in
            self.presenter.toggleRating(for: indexPath)
        }
        toggle.image = UIImage(systemName: "togglepower")
        toggle.backgroundColor = .systemGreen
            
        return UISwipeActionsConfiguration(actions: [toggle])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: nil) {(_, _, complitionHand) in
            self.presenter.deleteCell(for: indexPath)
        }

        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension ListReviewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return presenter.titleForHeaderInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ReviewTableViewCell {
            let model: Review = presenter.cellData(for: indexPath)
            cell.configure(with: model)
            return cell
        }
        return UITableViewCell()
    }
}

private extension ListReviewsController {
    
    func setup(){
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @objc func didTapAddReview() {
       
        let createReviewController = EditReviewController()
        
        createReviewController.complitionHandler = { [weak self] review in
            self?.review = review
            self?.presenter.addReviewCell()
        }
    
        navigationController?.pushViewController(createReviewController, animated: true)
    }
}
