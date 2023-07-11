//
//  AboutViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 2/27/23.
//

import UIKit
import MapboxMaps

class AboutViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let backArrowImage = UIImage(named: "back-button-white")
        navigationController?.navigationBar.backIndicatorImage = backArrowImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrowImage
        navigationController?.navigationBar.tintColor = .white
        
        submitButton.layer.borderWidth = 1.0
        submitButton.layer.borderColor = UIColor(white: 1.0, alpha: CGFloat(0.7)).cgColor
        submitButton.layer.cornerRadius = 21
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let docURL = URL(string: "https://forms.gle/ugvPzGKTcvCrdsn7A") else {return}
        UIApplication.shared.open(docURL, options: [:] )
    }
}
