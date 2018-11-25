//
//  CatalogsNavigator.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import UIKit

protocol CatalogsNavigator: class {
    func navigateToDetail()
}

protocol CatalogsDataPassing {
    var dataStore: CatalogsDataStore? { get }
}

final class CatalogsNavigatorMain: CatalogsNavigator, CatalogsDataPassing {
    
    weak var viewController: CatalogsViewController?
    var dataStore: CatalogsDataStore?
    
    func navigateToDetail() {
        let storyboard = UIStoryboard.init(name: "CatalogDetail", bundle: Bundle.main)
        let vc: CatalogDetailViewController = storyboard.instantiateViewController(withIdentifier: "CatalogDetailViewController") as! CatalogDetailViewController
        vc.navigator?.dataStore?.catalog = dataStore?.selectedCatalog
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
