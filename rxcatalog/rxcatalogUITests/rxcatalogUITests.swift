//
//  rxcatalogUITests.swift
//  rxcatalogUITests
//
//  Created by Aitor Pagán on 28/11/18.
//  Copyright © 2018 Aitor Pagán. All rights reserved.
//

import XCTest

class rxcatalogUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTapOnAnyItemWillNavigateToCatalogDetail() {
        app.launch()
        
        let collectionCell: XCUIElement = app.collectionViews.cells.firstMatch
        expectation(for: NSPredicate(format: "hittable == true"), evaluatedWith: collectionCell, handler: nil)
        waitForExpectations(timeout: 3) { (error) in
            if(error != nil) {
                XCTFail("Couldn't find any cell to tap on: \(self.app.debugDescription)")
            }
        }
        collectionCell.tap()
        
        XCTAssertTrue(app.staticTexts["lbl_retailer_name"].exists)
    }
    
    func testCouponCellShouldShowCouponLabel() {
        app.launch()
        
        let identifier = "coupon"
        let cell = app.cells.element
        let couponCell: XCUIElement = cell.staticTexts[identifier]
        //Avoid eternal loop
        while (!couponCell.exists && !app.cells.element(boundBy: app.cells.count - 1).isVisible) {
            app.swipeUp()
        }
        expectation(for: NSPredicate(format: "hittable == true"), evaluatedWith: couponCell, handler: nil)
        waitForExpectations(timeout: 3) { (error) in
            if(error != nil) {
                XCTFail("Couldn't find any coupon on: \(self.app.debugDescription)")
            }
        }
        
        XCTAssertTrue(cell.staticTexts["lbl_coupon_tag"].exists)
    }
}


extension XCUIElement {
    
    public var isVisible: Bool {
        return exists && !frame.isEmpty && XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }
}
