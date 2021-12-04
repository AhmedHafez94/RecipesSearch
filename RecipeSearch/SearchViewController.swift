//
//  ViewController.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/3/21.
//

import UIKit

class SearchViewController: UIViewController {
  
    

    @IBOutlet weak var recipesTableView: UITableView!
    
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello world 101")
        
        filtersCollectionView.dataSource = self
        filtersCollectionView.delegate = self
        filtersCollectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
    }


}


//MARK:-> TableView Methods

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "cell number \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToRecipeDetail", sender: self)
    }
    
    
}

//MARK:- collectionView Methods

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        return cell
    }
}

