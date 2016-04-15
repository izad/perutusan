//
//  PerutusanUITests.swift
//  PerutusanUITests
//
//  Created by Izad Che Muda on 4/11/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import XCTest

class PerutusanUITests: XCTestCase {
        
    let app = XCUIApplication()
    var navBar: XCUIElement!

        
    override func setUp() {
        super.setUp()
        
        setupSnapshot(app)
        app.launch()
        
        navBar = app.navigationBars["UTAMA"]
        let navBarExists = NSPredicate(format: "exists == true")
        expectationForPredicate(navBarExists, evaluatedWithObject: navBar, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
        XCTAssert(navBar.exists)
        
        let cells = app.tables.cells
        let cellsCountIsLargerThanZero = NSPredicate(format: "count > 0")
        expectationForPredicate(cellsCountIsLargerThanZero, evaluatedWithObject: cells, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
        XCTAssert(cells.count > 0)                        
    }

    override func tearDown() {
        super.tearDown()
    }

    func testUtama() {
        snapshot("utama")
    }

    func testDropdown() {
        navBar.otherElements.childrenMatchingType(.Button).element.tap()
        snapshot("dropdown")
    }

    func testDetails() {
        app.tables.cells.elementBoundByIndex(2).tap()                
        
        let staticTexts = app.tables.staticTexts
        let staticTextsAreMoreThanTwo = NSPredicate(format: "count > 2")
        expectationForPredicate(staticTextsAreMoreThanTwo, evaluatedWithObject: staticTexts, handler: nil)
        waitForExpectationsWithTimeout(10, handler: nil)
        XCTAssert(staticTexts.count > 2)
        
        snapshot("details")
    }
    
}
