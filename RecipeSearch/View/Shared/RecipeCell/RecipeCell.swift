//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/4/21.
//

import UIKit
import SDWebImage

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeHealthLabel: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(recipe: Recipe) {
        recipeImageView.sd_setImage(with: URL(string: recipe.image), placeholderImage: UIImage(named: "loading"))
        
        recipeTitleLabel.text = recipe.label
        recipeSource.text = recipe.source
        let healthLabels = recipe.healthLabels
        let healthLabeString = healthLabels.joined(separator: ",")
        recipeHealthLabel.text = healthLabeString
    }
    
}
