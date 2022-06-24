//
//  RecipeDetailsAssembly.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import UIKit

enum RecipeDetailsAssembly {
    static func createDetailsViewController(model: RecipeEntity) -> UIViewController {
        let router = RecipeDetailsRouter()
        let interactor = RecipeDetailsInteractor()
        let presenter = RecipeDetailsPresenter(model: model, interactor: interactor, router: router)
        let view = RecipeViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
