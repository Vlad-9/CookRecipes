//
//  DataManager.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import Foundation
import CoreData

protocol IDataManagerDelegate: AnyObject {
    func contentChangedHandler()
}

protocol IDataManager: AnyObject {
     var delegate: IDataManagerDelegate? { get set }
    func object(at indexPath: IndexPath) -> RecipeEntity
    func createRecipe(model: RecipeEntity)
    func deleteRecipe(_ recipe: RecipeEntity)
    func count() -> Int
   // func all()
}

final class DataManager: NSObject {

    // MARK: - Dependencies

    weak var delegate: IDataManagerDelegate?
    private let fetchResultController = CoreDataService.shared.fetchResultController

    // MARK: - Initializer

    init (delegate: IDataManagerDelegate) {
        super.init()
        fetchResultController.delegate = self
        performFetch()
        self.delegate = delegate
    }
}

// MARK: - IDataManager protocol

extension DataManager: IDataManager {



    func object(at indexPath: IndexPath) -> RecipeEntity {
         let model =  self.fetchResultController.object(at: indexPath)
        return RecipeEntity(model)
    }

    func createRecipe(model: RecipeEntity) {
        CoreDataService.shared.createRecipe(model: model)
    }

    func deleteRecipe(_ recipe: RecipeEntity) {
        guard let modelFromDB = self
                .fetchResultController
                .fetchedObjects?
                .first(where: { $0.uid == recipe.uid }) else { return }
        CoreDataService.shared.deleteRecipe(modelFromDB)
    }

    func count() -> Int {
        guard let count = self.fetchResultController.sections?.first?.numberOfObjects else { return 0 }
        return count
    }
}

// MARK: - Private

private extension DataManager {
    func performFetch() {
        do {
            try self.fetchResultController.performFetch()

        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate protocol

extension DataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.contentChangedHandler()
    }
}
