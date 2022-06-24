//
//  RecipeDetailsPresenter.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import UIKit

protocol IRecipeDetailsPresenter {
    func viewDidLoad()
    func saveRecipe()
}

final class RecipeDetailsPresenter {

    // MARK: - Dependencies

    private var recipe: RecipeEntity
    weak var view: IRecipeViewController?
    private var interactor: IRecipeDetailsInteractor?
    private var router: IRecipeDetailsRouter?
   
    // MARK: - Initializer

    init(model: RecipeEntity, interactor: IRecipeDetailsInteractor, router: IRecipeDetailsRouter) {
        self.recipe = model
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IRecipeDetailsPresenter protocol

extension RecipeDetailsPresenter: IRecipeDetailsPresenter {
    func viewDidLoad() {
        self.view?.setData(with: RecipeDetailsViewModel(from: recipe))
    }
    func saveRecipe() {
        self.interactor?.saveRecipe(recipe)
    }
}
extension RecipeDetailsPresenter: IDataManagerDelegate {
    func contentChangedHandler() {
        
    }    
}
