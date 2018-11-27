//
//  CatalogsViewControllerTests.swift
//  rxcatalogTests
//
//  Created by Aitor Pagán on 27/11/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import rxcatalog

private class InputSpy: CatalogsInput {
    
    private(set) var fetchCatalogsCalled = false
    func fetchCatalogs() {
        fetchCatalogsCalled = true
    }
    
    private(set) var catalogSelectedCalled = false
    func catalogSelected(request: CatalogsModels.Input.Request) {
        catalogSelectedCalled = true
    }
    
}

private class NavigatorSpy: CatalogsNavigator, CatalogsDataPassing {
    
    var navigateToDetailCalled = false
    func navigateToDetail() {
        navigateToDetailCalled = true
    }
    
    var dataStore: CatalogsDataStore?
    
}

class CatalogsViewControllerTests: XCTestCase {
    
    var window: UIWindow?
    var viewController: CatalogsViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Catalogs", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CatalogsViewController") as? CatalogsViewController
        window = UIWindow()
    }
    
    func addView() {
        window?.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }

    override func tearDown() {
       window = nil
    }

    func testViewDidLoadShouldAskInputForFetch() {
        let inputSpy = InputSpy()
        viewController.input = inputSpy
        addView()
        
        XCTAssertTrue(inputSpy.fetchCatalogsCalled)
    }
    
    func testCollectionItemDidTapShouldAskInputToSelectCatalog() {
        addView()
        let inputSpy = InputSpy()
        viewController.input = inputSpy
        
        viewController.collectionView(viewController.catalogsCollectionView!, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(inputSpy.catalogSelectedCalled)
    }
    
    func testCollectionItemDidTapShouldAskNavigatorToNavigateToDetail() {
        addView()
        let inputSpy = InputSpy()
        viewController.input = inputSpy
        let navigatorSpy = NavigatorSpy()
        viewController.navigator = navigatorSpy
        
        viewController.collectionView(viewController.catalogsCollectionView!, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(navigatorSpy.navigateToDetailCalled)
    }
}
