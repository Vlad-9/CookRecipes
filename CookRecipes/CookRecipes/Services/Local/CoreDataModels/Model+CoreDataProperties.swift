//
//  Model+CoreDataProperties.swift
//  CookRecipes
//
//  Created by Влад on 24.06.2022.
//
//

import Foundation
import CoreData


extension Model {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Model> {
        return NSFetchRequest<Model>(entityName: "Model")
    }

    @NSManaged public var author: String?
    @NSManaged public var calories: Int32
    @NSManaged public var date: Date?
    @NSManaged public var image: Data?
    @NSManaged public var ingridients: [String]?
    @NSManaged public var instructions: [String]?
    @NSManaged public var minutes: Int32
    @NSManaged public var name: String?
    @NSManaged public var rating: String?
    @NSManaged public var servings: Int32
    @NSManaged public var uid: UUID?

}

extension Model : Identifiable {

}
