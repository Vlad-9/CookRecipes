//
//  RecipeDetailsInteractor.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import Foundation

protocol IRecipeDetailsInteractor {
    func saveRecipe(_ recipe: RecipeEntity)
}

final class RecipeDetailsInteractor {

    // MARK: - Dependencies

    private lazy var dataManager: IDataManager = DataManager(delegate: self)

}
extension RecipeDetailsInteractor: IDataManagerDelegate {
    func contentChangedHandler() {
    }
}

extension RecipeDetailsInteractor: IRecipeDetailsInteractor {
    func saveRecipe(_ recipe: RecipeEntity) {
        self.dataManager.createRecipe(model: recipe)
    }
}
