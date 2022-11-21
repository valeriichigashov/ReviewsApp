import Foundation
import CoreData

struct WeakSubscriber {
    weak var value : Subscriber?
}

final class CoreDataManager {
    
    private lazy var subscribers : [WeakSubscriber] = []
    
    static let instatnce = CoreDataManager()
    private init() {}
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func entityForName(entityName: String) -> NSEntityDescription {
        
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ReviewDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

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
    
    func fetchData<T: DBObject, U: DTOObject>(from type: T.Type, to modelType: U.Type) -> [U] {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.getEntityName())
        var dtoObjects: [U] = []
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [T] {
        
                let dtoObject = result.toDTOObject() as! U
                dtoObjects.append(dtoObject)
            }
        } catch {
            print(error)
        }
        return dtoObjects
    }
    
    func addObject<U: DTOObject>(dtoObject: U) {
        
        _ = dtoObject.toDBObject()
        subscribers.forEach({ $0.value?.upate(subject: self)})
        saveContext()
    }
    
    func deleteObject<T: DBObject>(from type: T.Type, to modelID: String) {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.getEntityName())
        fetchRequest.predicate = NSPredicate(format: "id == %@", modelID)
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [T] {
                context.delete(result)
            }
            saveContext()
        } catch {
            print(error)
        }
    }
    
    func editObject<T: DBObject, U: DTOObject>(from type: T.Type, dtoObject: U, to modelID: String) {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: T.getEntityName())
        fetchRequest.predicate = NSPredicate(format: "id == %@", modelID)
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [T] {
                context.delete(result)
            }
            addObject(dtoObject: dtoObject)
        } catch {
            print(error)
        }
    }
    
    
    
    func subscribe(_ subscriber: Subscriber) {
        subscribers.append(WeakSubscriber(value: subscriber))
    }
}

protocol DBConvertible {
    
    func toDBObject() -> DBObject
}

protocol DTOConvertible {
    
    func toDTOObject() -> DTOObject
}

protocol DTOObject: DBConvertible {}
protocol DBObject: NSManagedObject, DTOConvertible {}

extension NSManagedObject {
    
    static func getEntityName() -> String {
        return "ReviewDB"
    }
}

protocol Subscriber: ListReviewsPresenter {
    
    func upate(subject: CoreDataManager)
}
