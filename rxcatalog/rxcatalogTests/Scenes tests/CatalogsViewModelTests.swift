//
//  CatalogsViewModelTests.swift
//  rxcatalogTests
//
//  Created by Aitor Pagán on 27/11/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import rxcatalog
import Domain
import RxSwift

private class CatalogsOutputSpy : CatalogsOutput {
    
    private(set) var displayCatalogsCalled = false
    func displayCatalogs(catalogs: CatalogsModels.Output.Catalog.ViewModel) {
        displayCatalogsCalled = true
    }
    
    private(set) var displayErrorCalled = false
    func displayError(error: CatalogsModels.Output.Catalog.ViewModelError) {
        displayErrorCalled = true
    }
}

internal class CatalogDataSourceProviderMock : CatalogDataSourceProvider {
    
    static let defaultCatalog = Catalog(id: "0", date_end: "100", retailerId: "0", retailerName: "retailer")
    
    enum MockError: Error {
        case doError
    }
    
    private let returnError: Bool
    
    init(onError: Bool) {
        self.returnError = onError
    }
    override func fetch() -> Observable<[Catalog]> {
        if (returnError) {
            return Observable.error(MockError.doError)
        } else {
            return Observable.just([CatalogDataSourceProviderMock.defaultCatalog])
        }
    }
}

class CatalogsViewModelTests: XCTestCase {
    
    var catalogsViewModel: CatalogsViewModel?
    let disposeBag = DisposeBag()
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }

    func testFetchWithSuccessOutputShouldCallDisplayCatalogs() {
        
        let viewModel = CatalogsViewModel(dataSource: CatalogDataSourceProviderMock(onError: false))
        let outputSpy = CatalogsOutputSpy()
        viewModel.output = outputSpy
        
        viewModel.fetchCatalogs()
        
        XCTAssertTrue(outputSpy.displayCatalogsCalled, "Fetch with success should call display catalogs")
    }
    
    func testFetchWithErrorOutputShouldCallDisplayError() {
        
        let viewModel = CatalogsViewModel(dataSource: CatalogDataSourceProviderMock(onError: true))
        let outputSpy = CatalogsOutputSpy()
        viewModel.output = outputSpy
        
        viewModel.fetchCatalogs()
        
        XCTAssertTrue(outputSpy.displayErrorCalled, "Fetch with error should call display error")
    }
}
