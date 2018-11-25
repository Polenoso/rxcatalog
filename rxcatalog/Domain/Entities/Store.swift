//
//  Store.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Store {
    
    public let distance: String
    public let latitude: String
    public let longitude: String
    public let phone_number: String
    public let store_address: String
    public let store_city: String
    public let store_id: String
    public let store_name: String
    public let store_zip_code: String
    public let web_url: String
    
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
