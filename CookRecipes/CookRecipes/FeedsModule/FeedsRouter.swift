//
//  FeedsRouter.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//


import UIKit

protocol IFeedsRouter: AnyObject {
    func openRecipeDetails(viewController: UIViewController, model: RecipeEntity)
}

final class FeedsRouter {}

extension FeedsRouter: IFeedsRouter {
    func openRecipeDetails(viewController: UIViewController, model: RecipeEntity) {
        viewController.present(RecipeDetailsAssembly.createDetailsViewController(model: model), animated: true)
    }
}
