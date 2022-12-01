import UIKit

class ListReviewsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var barButtonItem: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(didTapAddReview))
    }()

    override var navigationItem: UINavigationItem {
        let item = super.navigationItem
        item.rightBarButtonItem = barButtonItem
        item.title = "Reviews"
        return item
    }
    
    private lazy var presenter: ListReviewsOutput = {
        let presenter = ListReviewsPresenter(view: self)
        return presenter
    }()
    
    private lazy var dataSource: DataSource = {
        let datasource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, review) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ReviewTableViewCell
            cell?.configure(with: review)
            return cell
        })
        datasource.delegate = self
        return datasource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupUI()
    }
}

extension ListReviewsController: ListReviewsInput {
    
    func setSections(_ model: [Section]) {
        
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        model.forEach { section in
            snapshot.appendSections([section])
            snapshot.appendItems(section.cells)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ListReviewsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let editReviewController = EditReviewController()
        let model: Review = presenter.cellData(for: indexPath)
        editReviewController.configure(with: model)
        editReviewController.navigationItem.title = "Edit a review"
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

extension ListReviewsController: DataSourceDelegate {
    
    func titleForHeaderInSections(_ section: Int) -> String? {
        
        presenter.titleForHeaderInSection(section)
    }
}

private extension ListReviewsController {
    
    func setupUI(){
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    @objc func didTapAddReview() {
       
        let createReviewController = EditReviewController()
        createReviewController.navigationItem.title = "Create a review"
        navigationController?.pushViewController(createReviewController, animated: true)
    }
}

private class DataSource: UITableViewDiffableDataSource<Section, Review> {
    
    weak var delegate: DataSourceDelegate?
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        
        delegate?.titleForHeaderInSections(section) ?? "Title of Section"
    }
}
