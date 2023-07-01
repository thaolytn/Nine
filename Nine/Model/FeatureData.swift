//
//  FeatureData.swift
//  Nine
//
//  Created by Thaoly Ngo on 3/3/23.
//

import Foundation

struct FeatureData : Codable {
    let features : [Feature]
}

struct Feature : Codable {
    let properties : Property
}

struct Property : Codable {
    let name : String
    let address : String
    let phone : String
    let category : String
    let nationality : String
    let description : String
    let social : String
    let image : String
}
