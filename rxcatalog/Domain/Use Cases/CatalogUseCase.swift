//
//  CatalogUseCase.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift

protocol CatalogUseCase: UseCaseProtocol {
    func fetch() -> Observable<[Catalog]>
    func fetch(_ id:Int) -> Observable<Catalog>
}
