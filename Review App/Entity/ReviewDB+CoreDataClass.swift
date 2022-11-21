//
//  ReviewDB+CoreDataClass.swift
//  Review App
//
//  Created by Валерий on 14.11.2022.
//
//

import Foundation
import CoreData

@objc(ReviewDB)
public class ReviewDB: NSManagedObject {

    convenience init() {
        self.init(entity: CoreDataManager.instatnce.entityForName(entityName: "ReviewDB"), insertInto: CoreDataManager.instatnce.context)
    }
    
    convenience init(id: String,
                     title: String,
                     description: String ,
                     date: Date,
                     dateString: String?,
                     isRated: Bool,
                     ratingValue: Int) {

        self.init()
        self.id = UUID(uuidString: id) ?? UUID()
        self.titleReview = title
        self.descriptionReview = description
        self.dateReview = date
        self.dateString = dateString
        self.isRated = isRated
        self.ratingValue = Int16(ratingValue)
    }
}

extension ReviewDB: DBObject {
    
    func toDTOObject() -> DTOObject {
        
        return Review(from: self)
    }
}
