//
//  Store.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Store {
    
    let distance: Double
    let latitude: Double
    let longitude: Double
    let phone_number: String
    let store_address: String
    let store_city: String
    let store_id: Int
    let store_name: String
    let store_zip_code: String
    let web_url: String
    
}

extension Store: Codable {
    enum CodingKeys: String, CodingKey {
        case distance
        case latitude
        case longitude
        case phone_number
        case store_address
        case store_city
        case store_id
        case store_name
        case store_zip_code
        case web_url
    }
}
