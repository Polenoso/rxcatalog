//
//  Catalog.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Catalog {
    let catalog_id: Int
    let coupon: Coupon?
    let date_end: Int
    let nearest_store: Store
    let retailer_id: Int
    let retailer_name: String
    
}

extension Catalog: Codable {
    enum CodingKeys: String, CodingKey {
        case catalog_id
        case coupon
        case date_end
        case nearest_store
        case retailer_id
        case retailer_name
    }
}
