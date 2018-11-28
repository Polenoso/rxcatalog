//
//  CatalogsViewModel.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

protocol CatalogsInput {
    func fetchCatalogs()
    func catalogSelected(request: CatalogsModels.Input.Request)
}

protocol CatalogsDataStore {
    var selectedCatalog: Catalog? { get }
}

final class CatalogsViewModel: CatalogsInput, ViewModelKind, CatalogsDataStore {
    
    typealias CatalogOutput = CatalogsModels.Output.Catalog.Displayed
    var selectedCatalog: Catalog?
    var dataSource: CatalogDataSourceProvider
    weak var output: CatalogsOutput?
    var catalogs: [Catalog]?
    let disposeBag = DisposeBag()
    
    public init(dataSource: CatalogDataSourceProvider) {
        self.dataSource = dataSource
    }
    
    func fetchCatalogs() {
        presentLoading()
        dataSource.fetch()
            .subscribe {[unowned self] (event) in
            switch event{
            case .next(let catalogs):
                self.catalogs = catalogs
            case .error(let error):
                self.presentError(error)
            case .completed:
                self.presentCatalogs()
            }
        }.disposed(by: disposeBag)
    }
    
    private func presentError(_ error: Error) {
        output?.displayError(error: CatalogsModels.Output.Catalog.ViewModelError.init(data: error))
    }
    
    private func presentLoading() {
        let loading = CatalogOutput.init(image: nil, id: "", date: "", businessName: "", type: .loading)
        let presentedSections = CatalogsModels.Output.Catalog.ViewModel.init(data: [CatalogsModels.Output.Catalog.Sections.init(title: "Catálogos", catalogs: [loading]), CatalogsModels.Output.Catalog.Sections.init(title: "Cupones", catalogs: [loading])])
        output?.displayCatalogs(catalogs: presentedSections)
    }
    
    private func presentCatalogs() {
        var displayedSections = CatalogsModels.Output.Catalog.ViewModel.init(data: [])
        
        displayedSections.data.append(presentedCatalogs())
        
        displayedSections.data.append(presentedCoupons())
        
        output?.displayCatalogs(catalogs:displayedSections)
    }
    
    private func presentedCatalogs() -> CatalogsModels.Output.Catalog.Sections {
        var presentedCatalogs: [CatalogOutput] = []
        presentedCatalogs = catalogs!.filter({$0.coupon == nil}).compactMap({ (catalog) -> CatalogOutput? in
            return CatalogOutput.init(image: nil, id: catalog.catalog_id, date: DateUtils.stringDate(from: catalog.date_end.toInt(), with: .displayed), businessName: catalog.retailer_name, type: .catalog)
        })
        
        return CatalogsModels.Output.Catalog.Sections.init(title: "Catálogos".uppercased(), catalogs: presentedCatalogs)
    }
    
    private func presentedCoupons() -> CatalogsModels.Output.Catalog.Sections {
        var presentedCoupons: [CatalogOutput] = []
        presentedCoupons = catalogs!.filter({$0.coupon != nil}).compactMap({ (catalog) -> CatalogOutput? in
            return CatalogOutput.init(image: nil, id: catalog.catalog_id, date: DateUtils.stringDate(from: catalog.date_end.toInt(), with: .displayed), businessName: catalog.retailer_name, type: .coupon)
        })
        return CatalogsModels.Output.Catalog.Sections.init(title: "Cupones".uppercased(), catalogs: presentedCoupons)
    }
    
    func catalogSelected(request: CatalogsModels.Input.Request) {
        selectedCatalog = catalogs?.filter({$0.catalog_id == request.id}).first
    }
    
}
