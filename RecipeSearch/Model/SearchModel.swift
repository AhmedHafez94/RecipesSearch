//
//  File.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/7/21.
//

import Foundation

struct SearchModel {
   static var searchWord = ""
    static var from = 0
    static var filterIndex = 0
    static var filterWord = ""
    static var recipes: [Recipe] = []
    static var hasMore = false
    static var isFetchingRecipes = true
    
    
    static func makeNewSearchModel() {
//        SearchModel.searchWord = ""
        SearchModel.from = 0
//        SearchModel.filterIndex = 0
        SearchModel.filterWord = ""
        SearchModel.recipes = []
        SearchModel.hasMore = false
        SearchModel.isFetchingRecipes = true
    }
    
}

let url = "https://api.edamam.com/search?q=\(SearchModel.searchWord)&app_id=bb8ee61b&app_key=210feba02847a53b9f2c0d7ca4c9dff8\(SearchModel.filterWord)"


enum HealthFilters: String {
    case all = ""
    case lowSugar = "&health=low-sugar"
    case keto = "&health=keto-friendly"
    case vegan = "&health=vegan"
}

let healthFilters = ["", "&health=low-sugar", "&health=keto-friendly", "&health=vegan"]


