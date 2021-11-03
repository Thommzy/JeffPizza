//
//  TimJeffPizzaUITests.swift
//  TimJeffPizzaUITests
//
//  Created by Obeisun Timothy on 28/10/2021.
//

import XCTest

class TimJeffPizzaUITests: XCTestCase {
    
    func testClickAPersona() {
        
        let app = XCUIApplication()
        app.launch()
        let marriedBtn = app.buttons["MARRIED"]
        let spinner = app.activityIndicators["In progress"]
        app.buttons["MARRIED"].tap()
        app.activityIndicators["In progress"].tap()
        marriedBtn.tap()
        XCTAssertTrue(spinner.exists)
    }
}
