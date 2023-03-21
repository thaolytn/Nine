//
//  NationalityCollectionViewCell.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/16/23.
//

import UIKit

class NationalityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nationalityName: UILabel!
    
    var nationality : String? {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let nationality = nationality {
            nationalityName.text = nationality.uppercased()
        } else {
            nationalityName.text = nil
        }
    }


}
