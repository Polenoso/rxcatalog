//
//  Coupon.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

public struct Coupon {
    public let buttons: [CouponButton]?
    public let description: String
    
}

extension Coupon: Codable {
    enum CodingKeys: String, CodingKey {
        case buttons = "Buttons"
        case description
    }
}
