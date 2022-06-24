//
//  SavedRecipesPresenter.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import Foundation
import UIKit

protocol ISavedRecipesPresenter {
    func openRecipeDetails(at indexpath: IndexPath)
    func getRecipesCount() -> Int
    func getRecipeInfo(at indexpath: IndexPath) -> RecipeEntity?
    func deleteRecipe(at indexpath: IndexPath)
}

final class SavedRecipesPresenter {

    // MARK: - Dependencies

    weak var view: SavedRecipesViewController?
    private var interactor: ISavedRecipesInteractor?
    private var router: ISavedRecipesRouter?

    // MARK: - Initializer

    init( interactor: ISavedRecipesInteractor, router: ISavedRecipesRouter) {
        self.interactor = interactor
        self.router = router
        self.interactor?.delegate = self
    }
}

// MARK: - IRecipeDetailsPresenter protocol

extension SavedRecipesPresenter: ISavedRecipesPresenter {

    func deleteRecipe(at indexpath: IndexPath) {
        self.interactor?.deleteRecipe(at: indexpath)
    }
    
    func getRecipesCount() -> Int {
        interactor?.getRecipeCount() ?? 0
    }

    func getRecipeInfo(at indexpath: IndexPath) -> RecipeEntity? {
    interactor?.getRecipe(at: indexpath)
    }

    func openRecipeDetails(at indexpath: IndexPath) {
        guard let view = self.view,let model = (getRecipeInfo(at: indexpath)) else {return}
        self.router?.openRecipeDetails(viewController: view,
                                       model: model)
    }
}

// MARK: - SavedRecipesInteractorDelegate protocol

extension SavedRecipesPresenter: SavedRecipesInteractorDelegate {
    func handleContentChange() {
        self.view?.handleContentChange()
    }
}
