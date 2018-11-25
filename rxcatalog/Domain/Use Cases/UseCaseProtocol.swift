//
//  UseCaseProtocol.swift
//  Domain
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import RxSwift

public protocol UseCaseProtocol: class {
    //Implementing CRUD operations
    associatedtype UseCaseEntity
    func fetch() -> Observable<[UseCaseEntity]>
    func fetch(_ id: Int) -> Observable<UseCaseEntity>
    /* CRUD Operations (TO ADD)
    func save(_ object: UseCaseEntity) -> Observable<UseCaseEntity>
    func delete(_ object: UseCaseEntity) -> Observable<UseCaseEntity>
    */

}
