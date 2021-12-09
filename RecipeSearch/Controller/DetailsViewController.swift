//
//  DetailsViewController.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/4/21.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    var recipeImageUrl = ""
    var recipeTitle = ""
    var recipeIngredients: [String] = []
    var recipeUrl = ""
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = recipeTitle
        ingredientsTableView.dataSource = self
        recipeImageView.sd_setImage(with: URL(string: recipeImageUrl), placeholderImage: UIImage(named: "loading"))

        
    }
    
    
    @IBAction func recipeWebsiteButtonPressed(_ sender: UIButton) {
        
        
    }

}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = recipeIngredients[indexPath.row]
        
        return cell
    }
    
    
}
