//
//  FeatureCell.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/3/23.
//

import UIKit

class FeatureCell: UITableViewCell {

    @IBOutlet weak var featureNameLabel: UILabel!
    @IBOutlet weak var featureCategoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        featureCategoryLabel.layer.masksToBounds = true
        featureCategoryLabel.layer.cornerRadius = 14
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
