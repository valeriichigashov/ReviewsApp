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

class ListReviewsPresenter: Subscriber {
    
    func upate(subject: CoreDataManager) {
        viewDidLoad()
    }
    
    var coredata = CoreDataManager.instatnce
    private var sections = [Section]()
    private weak var view: ListReviewsInput?
    
    init(view: ListReviewsInput) {
        
        self.view = view
        coredata.subscribe(self)
    }
}

extension ListReviewsPresenter: ListReviewsOutput {
    
    func viewDidLoad() {
        
        createCells()
    }
    
//    func editReviewCell(_ model: Review) {
//
//        var cell = model
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd.MM.YYYY"
//        dateFormatter.dateStyle = .medium
//        cell.dateString = dateFormatter.string(from: model.date)
//
//        var allCells = sections.flatMap { $0.cells }
//        allCells.removeAll(where: { $0.id == model.id })
//        allCells.append(cell)
//
//        CoreDataManager.instatnce.editObject(from: ReviewDB.self, dtoObject: cell, to: model.id)
//
//        prepareSections(allCells: allCells.sorted(by: {$0.date > $1.date}))
//        view?.setSections()
//    }
    
    func deleteCell(for indexPath: IndexPath){
        
        let review = sections[indexPath.section].cells[indexPath.row]
        var allCells = sections.flatMap { $0.cells }
        allCells.removeAll(where: { $0.id == review.id })
        
        CoreDataManager.instatnce.deleteObject(from: ReviewDB.self, to: review.id)
        prepareSections(allCells: allCells.sorted(by: {$0.date > $1.date}))
        view?.setSections()
    }
    
    func toggleRating(for indexPath: IndexPath) {
        
        var review = sections[indexPath.section].cells[indexPath.row]
        review.isRated.toggle()
        if review.ratingValue > 0 {
            review.ratingValue = 0
        } else {
            review.ratingValue = 1
        }
        
        var allCells = sections.flatMap { $0.cells }
        allCells.removeAll(where: { $0.id == review.id })
        allCells.append(review)
        
        CoreDataManager.instatnce.editObject(from: ReviewDB.self, dtoObject: review, to: review.id)
        
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
        
        //let mockData = Review.testData
        let mockData = CoreDataManager.instatnce.fetchData(from: ReviewDB.self, to: Review.self)
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
