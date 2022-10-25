import UIKit

enum SectionType {
    case favorite
    case unrated
    
    var nameSection: String{
        switch self {
        case.favorite:
            return "Favorite"
        case.unrated:
            return "Unrated"
        }
    }
}

class ListReviewsController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let nameSection = ["Favorite","Unrated"]
    let data = ["Smile", "The Good House", "Samaritan"]
    let dataDescription = ["dsf sd fsdfsdfsdf sdfsdfsdf sdfsd fdsfsdfsdf sdfs dfsdfsd sdfdfwefwef wefwefewfefffw wefwefwewef",
                           "dsf sd fsdfsdfsdf sdfsdf sdfsdfdsfsdfsdf sdfsdfsdfsd sdfdfwwef wefwefefffw wefwewef",
                           "dsf sd fsdfsdfv sdf sdfsdfysdf sdyuiyiy fsdfdsf sdfsdf sddfsdfsd sdfdfwefhjkwef wefwefewfefffw wefwefwewef"]
    let dataOfDate = ["14.11.2032","02.02.1998","12.03.2012"]
    
    let mockData: [Review] = [Review(title: "sdf", desription: "sdfsdf"),
                              Review(title: "sdf", desription: "sdfsdf"),
                              Review(title: "sdf", desription: "sdfsdf")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = .zero
        //tableView.style = .grouped
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
}

extension ListReviewsController: UITableViewDelegate {
    
}

extension ListReviewsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.nameSection[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ReviewTableViewCell {
            cell.titleCell.text = self.data[indexPath.row]
            cell.descriptionCell.text = self.dataDescription[indexPath.row]
            cell.dateCell.text = self.dataOfDate[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
