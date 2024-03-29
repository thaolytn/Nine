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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var phoneButton: UIButton!
    
    let phoneButtonAttributes : [NSAttributedString.Key:Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    var featureName : String = ""
    var featureAddress : String = ""
    var featurePhone : String = ""
    var featureDescription : String = ""
    var featureSocial : String = ""
    var featureImage : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure navigation bar
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let backArrowImage = UIImage(named: "back-button-black")
        navigationController?.navigationBar.backIndicatorImage = backArrowImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrowImage
        navigationController?.navigationBar.tintColor = .black
        
        
        nameLabel.text = featureName 
        addressLabel.text = featureAddress
        descriptionLabel.text = featureDescription
        imageView.image = UIImage(named: "feature-photos/\(featureImage)")
       
        
        let attributeString = NSMutableAttributedString(string: featurePhone, attributes: phoneButtonAttributes)
        phoneButton.setAttributedTitle(attributeString, for: .normal)
       
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
        guard let infoURL = URL(string: featureSocial) else {return}
        UIApplication.shared.open(infoURL, options: [:] )
    }
    
    @IBAction func phoneButtonTapped(_ sender: Any) {
        let phoneNumber = featurePhone.replacingOccurrences(of: " |\\(|\\)|-", with: "", options: [.regularExpression])
        
        if Int(phoneNumber) == nil {
            return
        }
        guard let phoneURL = URL(string: "telprompt://\(phoneNumber)"), UIApplication.shared.canOpenURL(phoneURL) else {
            return
        }
        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
    }
    
}
