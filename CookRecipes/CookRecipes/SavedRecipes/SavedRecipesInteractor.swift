//
//  SavedRecipesInteractor.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import Foundation

protocol ISavedRecipesInteractor {

    func getRecipe(at: IndexPath) -> RecipeEntity
    func getRecipeCount() -> Int 
    func deleteRecipe(at: IndexPath)
    var delegate: SavedRecipesInteractorDelegate? { get set }
}

protocol SavedRecipesInteractorDelegate {
    func handleContentChange()
}

final class SavedRecipesInteractor {

    // MARK: - Dependencies

    lazy var dataManager: IDataManager = DataManager(delegate: self) 
    var delegate: SavedRecipesInteractorDelegate?

}

// MARK: - IDataManagerDelegate

extension SavedRecipesInteractor: IDataManagerDelegate {
    func contentChangedHandler() {
        delegate?.handleContentChange()
    }
}

// MARK: - ISavedRecipesInteractor

extension SavedRecipesInteractor: ISavedRecipesInteractor {
    func getRecipeCount() -> Int {
        dataManager.count()
    }

    func deleteRecipe(at: IndexPath) {
        dataManager.deleteRecipe(dataManager.object(at: at))
    }

    func getRecipe(at indexpath: IndexPath) -> RecipeEntity {
         dataManager.object(at: indexpath)
    }
}
