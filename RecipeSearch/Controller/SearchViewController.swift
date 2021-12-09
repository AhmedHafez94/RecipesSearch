//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/3/21.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
  
    var filtersArray = ["All", "Low Sugar", "Keto","Vegan"]
    let healthFilters = ["", "&health=low-sugar", "&health=keto-friendly", "&health=vegan"]
    var recipes: [Recipe] = []
    @IBOutlet weak var recipesSearchBar: UISearchBar!
    @IBOutlet weak var recipesTableView: UITableView!
    
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world 101")
        recipesSearchBar.delegate = self
        setupCollections()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailsViewController
        if let indexPath = recipesTableView.indexPathForSelectedRow{
               let selectedRow = indexPath.row
            let destVc = segue.destination as! DetailsViewController
            destVC.recipeImageUrl = recipes[selectedRow].image
            destVC.recipeTitle = recipes[selectedRow].label
            destVC.recipeIngredients = recipes[selectedRow].ingredientLines
            destVC.recipeUrl = recipes[selectedRow].url
            
           }
        
    }
    
    func setupCollections() {
        
        filtersCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        filtersCollectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        recipesTableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
    }
  
    
    func performSearch() {
//        let url = "https://api.edamam.com/search?q=chicken&app_id=bb8ee61b&app_key=210feba02847a53b9f2c0d7ca4c9dff8"
        
        let url = "https://api.edamam.com/search?q=\(SearchModel.searchWord)&app_id=bb8ee61b&app_key=210feba02847a53b9f2c0d7ca4c9dff8\(healthFilters[SearchModel.filterIndex])"
        print("url will be printed \(url)")
        let request = AF.request(url)
//        request.responseJSON { (response) in
//            guard response.error == nil else {
//                // handle error
//                return
//            }
//            print("response data \(response.data)")
//            let decoder = JSONDecoder()
//            let data = try! decoder.decode(RecipeData.self, from: response.data!)
//            print("data will be printed \(data)")
//        }
        request.responseDecodable(of: RecipeData.self) { (response) in
            if let error = response.error {
                print("error happened while fetching recipes \(error)")
                return
            }
            if let data = response.value {
                print("data will be printed \(data)")
                let hits = data.hits
                for hit in hits {
                    let recipe = hit.recipe
                    self.recipes.append(recipe)
                }
                self.recipesTableView.reloadData()
            }
            
        }
      
    }


}


//MARK:-> TableView Methods

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToRecipeDetail", sender: self)
    }
    
    
}

//MARK:- collectionView Methods

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        cell.filterLabel.text = filtersArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index path row \(indexPath.row)")
        SearchModel.filterIndex = indexPath.row
    }
}
//MARK:-> search bar methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        SearchModel.searchWord = text
        print("text from search bar \(text)")
        performSearch()
        recipesSearchBar.endEditing(true)

    }
}

