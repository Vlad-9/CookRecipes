//
//  SavedRecipesAssembly.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import UIKit

enum SavedRecipesAssembly {
    static func createDetailsViewController() -> UIViewController {
        let router = SavedRecipesRouter()
        let interactor = SavedRecipesInteractor()
        let presenter = SavedRecipesPresenter( interactor: interactor, router: router)
        let view = SavedRecipesViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
