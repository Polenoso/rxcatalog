//
//  CatalogsModels.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

enum CatalogsModels {
    
    enum Input {
        struct Request {
            let id: String
        }
        
    }
    
    enum Output {
        
        enum Catalog {
            enum Tipo {
                case coupon
                case catalog
                case loading
            }
            struct Displayed {
                let image: URL?
                let id: String
                let date: String?
                let businessName: String?
                let type: Tipo
            }
            struct Sections {
                let title: String?
                let catalogs: [Displayed]
            }
            
            struct ViewModel {
                var data: [Sections]
            }
        }
    }
}
