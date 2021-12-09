//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/3/21.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    var networkManager = NetworkManager()
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
        networkManager.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailsViewController
        if let indexPath = recipesTableView.indexPathForSelectedRow{
               let selectedRow = indexPath.row
            let destVc = segue.destination as! DetailsViewController
            destVC.recipeImageUrl = SearchModel.recipes[selectedRow].image
            destVC.recipeTitle = SearchModel.recipes[selectedRow].label
            destVC.recipeIngredients = SearchModel.recipes[selectedRow].ingredientLines
            destVC.recipeUrl = SearchModel.recipes[selectedRow].url
            
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

}


//MARK:-> TableView Methods

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.configure(recipe: SearchModel.recipes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToRecipeDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == SearchModel.recipes.count - 1 {
            if SearchModel.hasMore {
                SearchModel.from += 10
                print("will display cell")
                networkManager.performSearch()
            }
            
        }
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
        SearchModel.makeNewSearchModel()
        SearchModel.filterIndex = indexPath.row
        networkManager.performSearch()
    }
}
//MARK:-> search bar methods
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        SearchModel.searchWord = text
        print("text from search bar \(text)")
        networkManager.performSearch()
        recipesSearchBar.endEditing(true)

    }
}

//MARK:-> NetworkMangerDelegateMethods

extension SearchViewController: NetworkManagerProtocol {
    func didEndFetchingRecipes() {
        recipesTableView.reloadData()
    }
    
    
}

