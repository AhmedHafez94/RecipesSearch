//
//  FilterCell.swift
//  RecipeSearch
//
//  Created by Ahmed Hafez on 12/4/21.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var filterLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override var isSelected: Bool {
        didSet {
            filterLabel.backgroundColor = isSelected ? .gray : .white
        }
    }

}
