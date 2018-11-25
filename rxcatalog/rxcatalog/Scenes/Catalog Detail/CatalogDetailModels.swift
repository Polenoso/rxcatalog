//
//  CatalogDetailModels.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

enum CatalogDetailModels {
    
    enum Output {
        
        enum ViewModel {
            
            struct Displayed {
                let retailerName: String?
                let couponDescription: String?
                let isCoupon: Bool
                let storeTitle: String?
                let storeData: [(title: String?, description:String?)]
            }
        }
    }
}
