//
//  RecipeDetailsViewModel.swift
//  CookRecipes
//
//  Created by Влад on 24.06.2022.
//

import UIKit

struct RecipeDetailsViewModel {
    let title: String
    let author: String
    var image: UIImage?
    let rating:  String
    let minutes: Int
    let calories: Int
    let servings: Int
    var instructions: [String]
    var ingridients: [String]
    var isLocal: Bool
    init(from model: RecipeEntity) {
        self.title = model.name
        self.author = model.author
        image = model.image
        rating = model.rating
        minutes = model.minutes
        calories = model.calories
        servings = model.servings
        instructions = model.instructions
        ingridients = model.ingridients
        isLocal = model.isLocal
    }
}
