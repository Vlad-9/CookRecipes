//
//  FeedsDTO.swift
//  CookRecipes
//
//  Created by Влад on 21.06.2022.
//

import Foundation

struct FeedsDTO: Codable {
    var results: [Feed]
}

// MARK: - Feed

struct Feed: Codable {
    let name: String?
    let type: String?
    let category: String?
    let item: FullInfoRecipe?
    let items: [FullInfoRecipe]?
}
