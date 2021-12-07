//
//  Recipe.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/5/21.
//

import Foundation


struct RecipeData: Codable {
    var q: String
    var from: Int
    var to: Int
    var more: Bool
    var count: Int
    var hits: [Hit]

}

struct Hit: Codable {
    var recipe: Recipe
}

struct Recipe: Codable {
    var uri: String
    var label: String
    var image: String
    var source: String
    var url: String
    var healthLabels: [String]
    var ingredientLines: [String]
    
    
}
