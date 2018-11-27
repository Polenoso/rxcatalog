//
//  CatalogDetailViewModelTests.swift
//  rxcatalogTests
//
//  Created by Aitor Pagán on 27/11/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import rxcatalog
import Domain

private class CatalogDetailOutputSpy: CatalogDetailOutput {
    
    private(set) var displayDetailCalled = false
    func displayDetail(_ detail: CatalogDetailModels.Output.ViewModel.Displayed) {
        displayDetailCalled = true
    }
}

class CatalogDetailViewModelTests: XCTestCase {

    var viewModel: CatalogDetailViewModel?
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testFetchShouldCallOutputToDisplayDetail() {
        viewModel = CatalogDetailViewModel()
        let catalog = CatalogDataSourceProviderMock.defaultCatalog
        let output = CatalogDetailOutputSpy()
        viewModel?.output = output
        viewModel?.catalog = catalog
        
        viewModel?.fetch()
        
        XCTAssertTrue(output.displayDetailCalled)
    }

}
