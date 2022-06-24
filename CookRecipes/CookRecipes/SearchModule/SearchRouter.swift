//
//  SearchRouter.swift
//  CookRecipes
//
//  Created by Влад on 16.06.2022.
//

import Foundation
import UIKit

protocol ISearchRouter: AnyObject {
    func openRecipeDetails(viewController: UIViewController, model: RecipeEntity)
}

final class SearchRouter {}

extension SearchRouter: ISearchRouter {
    func openRecipeDetails(viewController: UIViewController, model: RecipeEntity) {
        viewController.present(RecipeDetailsAssembly.createDetailsViewController(model: model), animated: true)

    }
}
