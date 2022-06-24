//
//  CategoryViewModel.swift
//  CookRecipes
//
//  Created by Влад on 23.06.2022.
//

import UIKit

struct CategoryViewModel {
    var categoryName: String
    var recipes: [CategoryRecipeViewModel]
    init (from entity: FeedEntity) {
        self.categoryName = entity.name
        self.recipes = []
        for element in entity.items {
            self.recipes.append(CategoryRecipeViewModel(from: element))
        }
    }
}
struct CategoryRecipeViewModel {
    var title: String
    var image: UIImage?
    var calories: String?
    var time: String?
    init(from entity: RecipeEntity) {
        title = entity.name
        image = entity.image
        if entity.calories > 0 {
            calories = "\(entity.calories)"
        }
        if entity.minutes > 0 {
            time = "\(entity.minutes)"
        }
    }
}
