//
//  ListViewController.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/1/23.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var nationalityCollectionView: UICollectionView!
    var nationalities = [Nationality]()
    
    @IBOutlet weak var tableView: UITableView!
    
    private var features : [FeatureModel]?
    private var filteredFeatures = [FeatureModel]()
    private var featureManager : FeatureManager = FeatureManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // Configure navigation bar
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let backArrowImage = UIImage(named: "back-button-black")
        navigationController?.navigationBar.backIndicatorImage = backArrowImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backArrowImage
        navigationController?.navigationBar.tintColor = .black
        
        
        // Configure nationality collection view
        nationalityCollectionView.dataSource = self
        nationalityCollectionView.delegate = self
        nationalityCollectionView.collectionViewLayout = layout
        nationalityCollectionView.showsHorizontalScrollIndicator = false
        nationalityCollectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        nationalityCollectionView.backgroundColor = .white

        
        // Configure table view
        tableView.register(UINib(nibName: "FeatureCell", bundle: nil), forCellReuseIdentifier: "FeatureCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 130
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        features = featureManager.loadFeatures()
        fetchNationalities()
    }
    

    private func fetchNationalities() {
        var uniqueNationalities = Set<String>()
        
        if let nineFeatures = features {
            for feature in nineFeatures {
                uniqueNationalities.insert(feature.nationality)
            }
        }
        
        let nationalityArray  = Array(uniqueNationalities).sorted()
        
        for nationalityName in nationalityArray {
            let newNationality = Nationality(name: nationalityName, selected: false)
            nationalities.append(newNationality)
        }
    }
    
}




//MARK: - CollectionView Data Source Methods

extension ListViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nationalities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NationalityCell", for: indexPath) as! NationalityCollectionViewCell
        let nationality = nationalities[indexPath.item].name
        let selected = nationalities[indexPath.item].selected
        
        cell.nationality = nationality
        cell.backgroundColor = selected ? UIColor.black : UIColor.white
        cell.nationalityName.textColor = selected ? UIColor.white : UIColor.black
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
        nationalities[indexPath.row].selected = nationalities[indexPath.row].selected ? false : true
        filterFeatures()
        collectionView.reloadData()
    }
    
    func filterFeatures() {
        let selectedNationalities = nationalities.filter{$0.selected}
        
        if let currentFeatures = features {
            if selectedNationalities.isEmpty {
                filteredFeatures = []
            } else {
                filteredFeatures = currentFeatures.filter({ (feature: FeatureModel) -> Bool in
                    return selectedNationalities.contains{$0.name == feature.nationality}
                })
            }
        }
        
        tableView.reloadData()
    }

}



//MARK: - TableView Data Source Methods
extension ListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredFeatures.isEmpty {
            return features?.count ?? 1
        } else {
            return filteredFeatures.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeatureCell", for: indexPath) as! FeatureCell
        cell.selectionStyle = .none
        
        let feature : FeatureModel?
        
        if filteredFeatures.isEmpty {
            feature = features?[indexPath.row]
        } else {
            feature = filteredFeatures[indexPath.row]
        }
        
        if let safeFeature = feature {
            cell.featureNameLabel.text = safeFeature.name
            cell.featureCategoryLabel.text = safeFeature.category.uppercased()
        }
        
        return cell
    }
    
}

//MARK: - TableView Delegate Methods
    
extension ListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Feature Tapped in List")
        performSegue(withIdentifier: "goToDescription", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let row = tableView.indexPathForSelectedRow?.row {
            let selectedFeature : FeatureModel?
            
            if filteredFeatures.isEmpty {
                selectedFeature = features?[row]
            } else {
                selectedFeature = filteredFeatures[row]
            }
            
            let descVC = segue.destination as! DescriptionViewController
            descVC.featureName = selectedFeature?.name ?? ""
            descVC.featureAddress = selectedFeature?.address ?? ""
            descVC.featurePhone = selectedFeature?.phone ?? ""
            descVC.featureDescription = selectedFeature?.description ?? ""
            descVC.featureSocial = selectedFeature?.social ?? ""
            descVC.featureImage = selectedFeature?.image ?? ""
            
            
        }
    }
    
    
}

