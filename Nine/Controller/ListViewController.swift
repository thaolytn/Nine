//
//  ListViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/1/23.
//

import Foundation
import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    var categories = [String]()
    
    var features : [FeatureModel]?
    var featureManager : FeatureManager = FeatureManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.collectionViewLayout = layout
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

        features = featureManager.loadFeatures()
        categories = fetchCategories()
    }
    

    func fetchCategories() -> [String] {
        var availableCategories = [String]()
        
        if let nineFeatures = features {
            for feature in nineFeatures {
                availableCategories.append(feature.category)
            }
        }
        
        return Array(Set(availableCategories))
    }
    
}


//MARK: - CollectionView Data Source Methods

extension ListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CATEGORIES COUNT: \(categories.count)")
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.item]
        
        cell.category = category
        cell.backgroundColor = UIColor.white
        cell.categoryName.textColor = UIColor.black
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 18
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}


//MARK: - CollectionView Delegate Methods
extension ListViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCollectionViewCell
        
        cell.backgroundColor = UIColor.black
        cell.categoryName.textColor = UIColor.white
        
    }

    
}
