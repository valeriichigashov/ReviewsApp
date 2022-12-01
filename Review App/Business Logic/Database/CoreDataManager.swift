import Foundation
import CoreData

protocol DBConvertible {
    func toDBObject() -> DBObject
}
protocol DTOConvertible {
    func toDTOObject() -> DTOObject
}
protocol DTOObject: DBConvertible {}
protocol DBObject: NSManagedObject, DTOConvertible {
    var uuid: String { get }
}
protocol Subscriber: ListReviewsPresenter {
    func update(subject: SubjectType)
}

struct WeakSubscriber {
    weak var value : Subscriber?
}

enum SubjectType {
    
    case updateObject(DTOObject)
    case deleteObject(_ id: [String])
}

final class CoreDataManager {
    
    private lazy var subscribers : [WeakSubscriber] = []
    static let instatnce = CoreDataManager()
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ReviewDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func entityForName(entityName: String) -> NSEntityDescription {
        
        return NSEntityDescription.entity(forEntityName: entityName, in: context) ?? ReviewDB.entity()
    }
    
    func fetchData<T: DBObject, U: DTOObject>(from type: T.Type, to modelType: U.Type) -> [U] {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.getEntityName())
        var dtoObjects: [U] = []
        do {
            guard let results = try context.fetch(fetchRequest) as? [T] else { return [] }
            for result in results {
                guard let dtoObject = result.toDTOObject() as? U else { return [] }
                dtoObjects.append(dtoObject)
            }
        } catch {
            print(error)
        }
        return dtoObjects
    }
    
    func addObject<T: DBObject, U: DTOObject>(from type: T.Type, dtoObject: U) {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.getEntityName())
        do {
            guard let results = try context.fetch(fetchRequest) as? [T] else { return }
            let dbObject = dtoObject.toDBObject()
            for result in results {
                if dbObject.uuid == result.uuid {
                    context.delete(result)
                }
            }
            saveContext()
            subscribers.forEach({ $0.value?.update(subject: .updateObject(dtoObject))})
        } catch {
            print(error)
        }
    }
    
    func deleteObject<T: DBObject>(from type: T.Type, _ predicate: NSPredicate) {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.getEntityName())
        fetchRequest.predicate = predicate
        do {
            var array: [String] = []
            guard let results = try context.fetch(fetchRequest) as? [T] else { return }
            for result in results {
                context.delete(result)
                array.append(result.uuid)
            }
            saveContext()
            subscribers.forEach({ $0.value?.update(subject: .deleteObject(array))})
        } catch {
            print(error)
        }
    }
    
    func subscribe(_ subscriber: Subscriber) {
        subscribers.append(WeakSubscriber(value: subscriber))
    }
}

private extension CoreDataManager {
    
    func saveContext() {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension NSManagedObject {
    
    static func getEntityName() -> String {
        return "ReviewDB"
    }
}
