//
//  SavedRecipesRouter.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import Foundation
import UIKit

protocol ISavedRecipesRouter: AnyObject {
    func openRecipeDetails(viewController: UIViewController, model: RecipeEntity)
}

final class SavedRecipesRouter {}

extension SavedRecipesRouter: ISavedRecipesRouter {
    func openRecipeDetails(viewController: UIViewController, model: RecipeEntity) {
        viewController.navigationController?.pushViewController(RecipeDetailsAssembly.createDetailsViewController(model: model), animated: true)
    }
}
