//
//  SearchEntity.swift
//  CookRecipes
//
//  Created by Влад on 18.06.2022.
//

import Foundation
import UIKit
struct RecipeEntity {
    let name: String
    let author: String
    var image: UIImage?
    let imageURL: URL?
    let rating:  String
    let minutes: Int
    let calories: Int
    let servings: Int
    var instructions: [String]
    var ingridients: [String]
    var isLocal: Bool
    var uid: UUID?
    init(_ model: Model) {
        self.name = model.name ?? ""
        self.author = model.author ?? ""
        self.imageURL = nil
        self.rating =  model.rating ?? ""
        if let modelImage = model.image {
            self.image = UIImage(data: modelImage)
        }
        self .minutes = Int(model.minutes)
        self.calories = Int(model.calories)
        self.servings = Int(model.servings)
        self.instructions = model.instructions ?? [String]()
        self.ingridients = model.ingridients ?? [String]()
        self.isLocal = true
        self.uid = model.uid
    }
    
    init (from model: FullInfoRecipe) {
        self.name = model.name ?? ""
        self.author = model.credits?.first?.name ?? ""
        self.imageURL = model.thumbnailURL
        if let newRating = model.userRating?.score {
            self.rating = String(format: "%.01f", newRating * 5)
        } else {
            self.rating = ""
        }
        self .minutes = model.minutes ?? 0
        self.calories = model.nutrition?.calories ?? 0
        self.servings = model.numServings ?? 0
        self.instructions = [String]()
        self.ingridients = [String]()
        self.isLocal = false
        if let arrayModel = model.instructions {
            for inst in arrayModel {

                if let instruction = inst.displayText {
                    self.instructions.append(instruction)
                }
            }
        }
        if let ingridientsModel = model.sections?.first?.components {
            for elem in ingridientsModel {
                if let ingridient = elem.rawText{
                    self.ingridients.append(ingridient)
                }
            }
        }
    }
}
