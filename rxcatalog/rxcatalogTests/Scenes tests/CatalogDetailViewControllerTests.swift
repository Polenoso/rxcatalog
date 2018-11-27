//
//  CatalogDetailViewControllerTests.swift
//  rxcatalogTests
//
//  Created by Aitor Pagán on 27/11/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest
@testable import rxcatalog

private class CatalogDetailInputSpy: CatalogDetailInput {
    
    private(set) var fetchCalled = false
    func fetch() {
        fetchCalled = true
    }
}

class CatalogDetailViewControllerTests: XCTestCase {

    var window: UIWindow?
    var viewController: CatalogDetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "CatalogDetail", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CatalogDetailViewController") as? CatalogDetailViewController
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
        let input = CatalogDetailInputSpy()
        viewController.input = input
        
        addView()
        
        XCTAssertTrue(input.fetchCalled)
    }

}
