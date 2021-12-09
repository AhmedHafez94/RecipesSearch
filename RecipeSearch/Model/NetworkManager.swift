//
//  NetworkManager.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/9/21.
//

import Foundation
import Alamofire

protocol NetworkManagerProtocol: AnyObject {
    func didEndFetchingRecipes()
}

class NetworkManager {
    
    let healthFilters = ["", "&health=low-sugar", "&health=keto-friendly", "&health=vegan"]
    
    var delegate: NetworkManagerProtocol?
    
    func performSearch() {
        SearchModel.isFetchingRecipes = true
        var recipes: [Recipe] = []
        let url = "https://api.edamam.com/search?q=\(SearchModel.searchWord)&app_id=bb8ee61b&app_key=210feba02847a53b9f2c0d7ca4c9dff8\(healthFilters[SearchModel.filterIndex])&from=\(SearchModel.from)"
        print("url will be printed \(url)")
        let request = AF.request(url)
        request.responseDecodable(of: RecipeData.self) { (response) in
            SearchModel.isFetchingRecipes = false
            if let error = response.error {
                print("error happened while fetching recipes \(error)")
                return
            }
            if let data = response.value {
                print("data will be printed \(data)")
                SearchModel.hasMore = data.more
                let hits = data.hits
                for hit in hits {
                    let recipe = hit.recipe
                    SearchModel.recipes.append(recipe)
                }
                self.delegate?.didEndFetchingRecipes()
//                self.recipesTableView.reloadData()
            }
            
        }
      
    }
}
