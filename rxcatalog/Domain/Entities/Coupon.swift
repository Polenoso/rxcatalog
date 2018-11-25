//
//  Coupon.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Coupon {
    let buttons: [CouponButton]?
    let description: String
    
}

extension Coupon: Codable {
    enum CodingKeys: String, CodingKey {
        case buttons
        case description
    }
}
