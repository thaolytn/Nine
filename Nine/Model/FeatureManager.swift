//
//  LocationManager.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/3/23.
//

import Foundation

struct FeatureManager {
    
    func loadFeatures() -> [FeatureModel]? {
        let geoJSONFileURL = Bundle.main.url(forResource: "NineFeatures", withExtension: "geojson")!
        let data = try! Data(contentsOf: geoJSONFileURL)
        return parseGeoJSON(data)
    }
    
    func parseGeoJSON(_ featureData: Data?) -> [FeatureModel]? {
        
        let decoder = JSONDecoder()
        do {
            var features = [FeatureModel]()
            let decodedData = try decoder.decode(FeatureData.self, from: featureData!)
            
            for feature in decodedData.features {
                let name = feature.properties.name
                let address = feature.properties.address
                let category = feature.properties.category
                
                let featureModel = FeatureModel(name: name, address: address, category: category)
                features.append(featureModel)
            }
            
            return features
        } catch {
            return nil
        }
    }
    
}
