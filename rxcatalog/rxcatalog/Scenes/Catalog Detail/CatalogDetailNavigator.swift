//
//  CatalogDetailNavigator.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation

protocol CatalogDetailNavigator: class {
    
}

protocol CatalogDetailDataPassing {
    var dataStore: CatalogDetailDataStore? { get }
}

final class CatalogDetailNavigatorMain: CatalogDetailNavigator, CatalogDetailDataPassing {
    var dataStore: CatalogDetailDataStore?
    
}
