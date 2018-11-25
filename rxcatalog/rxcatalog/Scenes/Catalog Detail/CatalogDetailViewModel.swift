//
//  CatalogDetailViewModel.swift
//  rxcatalog
//
//  Created by Aitor Pagán on 25/11/2018.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import Foundation
import Domain

protocol CatalogDetailInput: class {
    func fetch()
}

protocol CatalogDetailDataStore: class {
    var catalog: Catalog? { get set }
}

final class CatalogDetailViewModel: CatalogDetailInput, CatalogDetailDataStore {
    
    var catalog: Catalog?
    weak var output: CatalogDetailOutput?
    
    func fetch() {
        var storeData: [(title: String?, description:String?)] = []
        var storeTitle = "No hay información de tiendas cercanas"
        if(catalog?.nearest_store != nil) {
            storeTitle = "Tienda más cercana a la promoción"
            storeData.append((title: "Tienda", description: catalog?.nearest_store?.store_name))
            storeData.append((title: "Distancia", description: "\(catalog?.nearest_store?.distance ?? "0")km"))
            storeData.append((title: "Teléfono", description: catalog?.nearest_store?.phone_number))
            storeData.append((title: "Dirección", description: catalog?.nearest_store?.store_address))
            storeData.append((title: "Ciudad", description: catalog?.nearest_store?.store_city))
            storeData.append((title: "C.P.", description: catalog?.nearest_store?.store_zip_code))
            storeData.append((title: "Website", description: catalog?.nearest_store?.web_url))
        }
        let retailer = catalog?.retailer_name
        let couponDesc = catalog?.coupon?.description
        let isCoupon = catalog?.coupon != nil
        output?.displayDetail(CatalogDetailModels.Output.ViewModel.Displayed.init(retailerName: retailer, couponDescription: couponDesc, isCoupon: isCoupon, storeTitle: storeTitle, storeData: storeData))
    }
    
}
