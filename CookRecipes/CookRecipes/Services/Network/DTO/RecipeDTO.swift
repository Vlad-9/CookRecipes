//
//  RecipeDTO.swift
//  CookRecipes
//
//  Created by Влад on 08.06.2022.
//

import Foundation

struct RecipeDTO: Codable {
    var results: [FullInfoRecipe]
}

struct FullInfoRecipe: Codable {
    let name: String?
    let thumbnailURL: URL
    let instructions: [Instructions]?
    let nutrition: Nutrition?
    let numServings: Int?
    let userRating: UserRating?
    let country: String?
    let id: Int?
    let credits: [Credits]?
    let createdAt: Int?
    let minutes: Int?
    let sections: [Section]?
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case thumbnailURL = "thumbnail_url"
        case numServings = "num_servings"
        case userRating = "user_ratings"
        case country
        case name
        case instructions
        case nutrition
        case id
        case minutes = "cook_time_minutes"
        case sections
        case credits
    }
}

struct Section: Codable {
    let components: [Component]?
}
struct Credits: Codable {
    let name: String?
}
struct Component: Codable {
    let position: Int?
    let rawText: String?
    enum CodingKeys: String, CodingKey {
        case position
        case rawText = "raw_text"
    }
}

struct UserRating: Codable {
    let positive: Int?
    let negative: Int?
    let score: Double?
    enum CodingKeys: String, CodingKey {
        case positive = "count_positive"
        case negative = "count_negative"
        case score
    }
}

struct Instructions: Codable {
    let position: Int?
    let displayText: String?
    enum CodingKeys: String, CodingKey {
        case position
        case displayText = "display_text"
    }
}

struct Nutrition: Codable {
    let fiber: Int?
    let calories: Int?
    let fat: Int?
    let protein: Int?
    let sugar: Int?
}

//// MARK: - Recipe
//
//struct Recipe: Codable {
//    let name: String
//    let id: Int
//    let thumbnailURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case id
//        case thumbnailURL = "thumbnail_url"
//    }
//}
