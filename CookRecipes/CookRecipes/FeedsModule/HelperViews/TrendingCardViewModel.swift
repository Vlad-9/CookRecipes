//
//  TrendingCardViewModel.swift
//  CookRecipes
//
//  Created by Влад on 24.06.2022.
//

import UIKit

struct TrendingCardViewModel {
    let rating: String
    let author: String
    let title: String
    var image: UIImage?
    init(from entity:  RecipeEntity) {
        self.rating = entity.rating
        self.author = entity.author
        self.title = entity.name
        self.image = entity.image
    }
}
