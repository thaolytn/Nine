//
//  DescriptionViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/21/23.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var featureName : String = ""
    var featureAddress : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure navigation bar
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let backArrowImage = UIImage(named: "back-button-black")
        navigationController?.navigationBar.backIndicatorImage = backArrowImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrowImage
        navigationController?.navigationBar.tintColor = .black
        
        nameLabel.text = featureName.uppercased()
        addressLabel.text = featureAddress
    }
    
  
    @IBAction func directionButtonTapped(_ sender: UIBarButtonItem) {
        guard let url = URL(string:"comgooglemaps://") else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            let name = featureName.replacingOccurrences(of: " ", with: "+")
            
            guard let fullURL = URL(string: "comgooglemaps://?q=\(name)&zoom=15&views=traffic") else { return }
            
            UIApplication.shared.open(fullURL, options: [:])
        }
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        guard let infoURL = URL(string: "https://www.google.com") else {return}
        UIApplication.shared.open(infoURL, options: [:] )
    }
    
    
}
