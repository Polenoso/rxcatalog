//
//  CatalogApiProvider.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import Networking

final class CatalogApiProvider: CatalogDataSourceProvider {
    
    enum Paths: String {
        case offers = "offers.json"
    }
    
    var network: NetworkingProtocol
    
    static func build() -> CatalogApiProvider {
        return CatalogApiProvider(with: Networking.buildDefaultNetwork(with: APIProviderConfig.baseUrl.rawValue))
    }
    
    private init(with network: NetworkingProtocol) {
        self.network = network
    }
    
    override func fetch() -> Observable<[Catalog]> {
        return network.getItems(path: Paths.offers.rawValue, params: nil, headers: nil).observeOn(MainScheduler.instance)
    }
    
    override func fetch(_ id: Int) -> Observable<Catalog> {
        return network.getItem(path: "\(Paths.offers.rawValue)\(id)", params: nil, headers: nil).observeOn(MainScheduler.instance)
    }

}
