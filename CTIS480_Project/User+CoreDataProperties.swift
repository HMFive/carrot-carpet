//
//  User+CoreDataProperties.swift
//  
//
//  Created by Yusuf Çiftci on 29.12.2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int32
    @NSManaged public var bmr: Double
    @NSManaged public var gender: String?
    @NSManaged public var height: Int32
    @NSManaged public var name: String?
    @NSManaged public var weight: Int32

}
