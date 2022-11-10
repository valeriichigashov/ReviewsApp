import Foundation

enum Section {
    
    case favorite(_ cells: [Review])
    case unrated(_ cells: [Review])
    
    var nameSection: String {
        switch self {
        case.favorite:
            return "Favorite"
        case.unrated:
            return "Unrated"
        }
    }
    
    var cells: [Review] {
        switch self {
        case .favorite(let array):
            return array
        case .unrated(let array):
            return array
        }
    }
}

class ListReviewsPresenter {
    
    private var review = Review(title: "", desription: "", date: Date(), isRated: false, ratingValue: 0)
    
    private var sections = [Section]()
    private weak var view: ListReviewsInput?
    
    init(view: ListReviewsInput) {
        
        self.view = view
    }
}

extension ListReviewsPresenter: ListReviewsOutput {
    
    func viewDidLoad() {
        
        createCells()
    }
    
    func addReviewCell() {
        
        let cell = view?.setNewReviewCell() ?? review
        var allCells = sections.flatMap { $0.cells }
        allCells.append(cell)
        
        prepareSections(allCells: allCells.sorted(by: {$0.date > $1.date}))
        view?.setSections()
    }
    
    func editReviewCell(for indexPath: IndexPath) {
        
        let selectCell = sections[indexPath.section].cells[indexPath.row]
        let editCell = view?.setNewReviewCell() ?? review
        var allCells = sections.flatMap { $0.cells }
        allCells.removeAll(where: { $0.id == selectCell.id })
        allCells.append(editCell)
        
        prepareSections(allCells: allCells.sorted(by: {$0.date > $1.date}))
        view?.setSections()
    }
    
    func deleteCell(for indexPath: IndexPath){
        
        let cell = sections[indexPath.section].cells[indexPath.row]
        
        var allCells = sections.flatMap { $0.cells }
        allCells.removeAll(where: { $0.id == cell.id })
        
        prepareSections(allCells: allCells.sorted(by: {$0.date > $1.date}))
        view?.setSections()
    }
    
    func toggleRating(for indexPath: IndexPath) {
        
        var cell = sections[indexPath.section].cells[indexPath.row]
        cell.isRated.toggle()
        cell.ratingValue = 0
        
        var allCells = sections.flatMap { $0.cells }
        allCells.removeAll(where: { $0.id == cell.id })
        allCells.append(cell)
        
        prepareSections(allCells: allCells.sorted(by: {$0.date > $1.date}))
        view?.setSections()
    }
    
    func numberOfSections() -> Int {
        
        sections.count
    }
    
    func cellData(for indexPath: IndexPath) -> Review {
        
        sections[indexPath.section].cells[indexPath.row]
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        
        sections[section].cells.count
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        
        sections[section].nameSection
    }
}

private extension ListReviewsPresenter {
    
    func createCells() {
        
        let mockData = Review.testData
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        dateFormatter.dateStyle = .medium
        var favorite = [Review]()
        var unrated = [Review]()
        
        for var review in mockData {
            review.dateString = dateFormatter.string(from: review.date)
            review.isRated ? favorite.append(review) : unrated.append(review)
        }
        
        var sections = [Section]()
        if !favorite.isEmpty {
            
            sections.append(.favorite(favorite.sorted(by: {$0.date > $1.date})))
        }
        if !unrated.isEmpty {
            
            sections.append(.unrated(unrated.sorted(by: {$0.date > $1.date})))
        }
        self.sections = sections
        
        view?.setSections()
    }
    
    func prepareSections(allCells: [Review]) {
    
        var favorite = [Review]()
        var unrated = [Review]()
        
        allCells.forEach { review in
            
            review.isRated ? favorite.append(review) : unrated.append(review)
        }
        var sections = [Section]()
        if !favorite.isEmpty {
            
            sections.append(.favorite(favorite))
        }
        if !unrated.isEmpty {
            
            sections.append(.unrated(unrated))
        }
        self.sections = sections
    }
}
