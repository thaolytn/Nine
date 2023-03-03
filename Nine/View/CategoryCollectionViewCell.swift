//
//  CategoryCollectionViewCell.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/3/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    
    var category : String? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let category = category {
            categoryName.text = category.uppercased()
        } else {
            categoryName.text = nil
        }
    }
}
