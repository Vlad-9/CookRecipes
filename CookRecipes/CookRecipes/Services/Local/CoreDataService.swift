//
//  CoreDataService.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import Foundation
import CoreData

final class CoreDataService {

    // MARK: - Dependencies

    static let shared = CoreDataService()
    var fetchResultController: NSFetchedResultsController<Model> {
        return NSFetchedResultsController(fetchRequest: self.fetchRequest(),
                                          managedObjectContext: self.context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }

    // MARK: - Initializer

    private init() {}

    // MARK: - Private

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CookRecipes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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

    func createRecipe(model: RecipeEntity) {
        let recipeEntity = Model(context: self.context)
        recipeEntity.ingridients = model.ingridients
        recipeEntity.instructions = model.instructions
        recipeEntity.name = model.name
        recipeEntity.minutes = Int32(model.minutes)
        recipeEntity.rating = model.rating
        recipeEntity.date = Date()
        recipeEntity.image = model.image?.jpegData(compressionQuality: 1)
        recipeEntity.servings = Int32(model.servings)
        recipeEntity.calories = Int32(model.calories)
        recipeEntity.author = model.author
        recipeEntity.uid = UUID()

        self.saveContext()
    }

    func deleteRecipe(_ recipe: NSManagedObject) {
        context.delete(recipe)
        saveContext()
    }
}

private extension CoreDataService {
    func fetchRequest() -> NSFetchRequest<Model> {
        let request: NSFetchRequest<Model> = Model.fetchRequest()
        request.sortDescriptors = [.init(keyPath: \Model.date, ascending: false)]
        return request
    }
}
