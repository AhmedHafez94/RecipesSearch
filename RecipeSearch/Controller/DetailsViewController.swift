//
//  DetailsViewController.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/4/21.
//

import UIKit
import SDWebImage
import SafariServices

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
        if let url = URL(string: recipeUrl) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        
        if let url = URL(string: recipeUrl) {
            // set up activity view controller
           
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
        
        
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
