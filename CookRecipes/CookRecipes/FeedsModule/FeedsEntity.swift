//
//  FeedsEntity.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import Foundation

struct FeedEntity {
    let name: String
    let type: String
    let category: String
    var items: [RecipeEntity]
    init (from model: Feed) {
        self.name = model.name ?? ""
        self.type = model.type ?? ""
        self.category = model.category ?? ""
        var convertedItems: [RecipeEntity] = []
        if let models = model.items {
            for item in models {
                convertedItems.append(RecipeEntity(from: item))
            }
        }
        self.items = convertedItems
    }
}
