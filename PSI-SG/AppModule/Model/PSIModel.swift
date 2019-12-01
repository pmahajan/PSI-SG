//
//  PSIModel.swift
//  PSI-SG
//
//  Created by Praful Mahajan on 30/11/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation
import MapKit

// MARK: - Welcome
struct PSIModel: Codable {
    let regionMetadata: [RegionMetadata]
    let items: [Item]
    let apiInfo: APIInfo

    enum CodingKeys: String, CodingKey {
        case regionMetadata = "region_metadata"
        case items
        case apiInfo = "api_info"
    }
}

// MARK: - APIInfo
struct APIInfo: Codable {
    let status: String
}

// MARK: - Item
struct Item: Codable {
    let timestamp, updateTimestamp: String
    let readings: [String: Reading]

    enum CodingKeys: String, CodingKey {
        case timestamp
        case updateTimestamp = "update_timestamp"
        case readings
    }
}

// MARK: - Reading
struct Reading: Codable {
    let west, national, east, central: Double
    let south, north: Double
}

// MARK: - RegionMetadatum
struct RegionMetadata: Codable {
    let name: String
    let labelLocation: LabelLocation

    enum CodingKeys: String, CodingKey {
        case name
        case labelLocation = "label_location"
    }
}

// MARK: - LabelLocation
struct LabelLocation: Codable {
    let latitude, longitude: Double
}

class PSIAnnotation: MKPointAnnotation {
    var identifire = ""

}
