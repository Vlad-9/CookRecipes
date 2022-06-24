//
//  SearchViewModel.swift
//  CookRecipes
//
//  Created by Влад on 24.06.2022.
//

import UIKit

struct SearchViewModel {
    var title: String
    var image: UIImage?
    var author: String
    var rating: String
    init(from model: RecipeEntity){
        self.title = model.name
        self.image = model.image
        self.author = model.author
        self.rating = model.rating
    }
}
