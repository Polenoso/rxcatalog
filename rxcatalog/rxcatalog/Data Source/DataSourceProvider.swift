//
//  DataSourceProvider.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Domain
import RxSwift

protocol DataSourceProvider: UseCaseProtocol {
    
}

class CatalogDataSourceProvider: DataSourceProvider {
    func fetch() -> Observable<[Catalog]> {
        return Observable.empty()
    }
    
    func fetch(_ id: Int) -> Observable<Catalog> {
        return Observable.empty()
    }
    
    typealias UseCaseEntity = Catalog
}
