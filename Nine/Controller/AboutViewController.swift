//
//  AboutViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 2/27/23.
//

import UIKit
import MapboxMaps

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let backArrowImage = UIImage(named: "back-button-white")
        navigationController?.navigationBar.backIndicatorImage = backArrowImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrowImage
        navigationController?.navigationBar.tintColor = .white
    }
}
