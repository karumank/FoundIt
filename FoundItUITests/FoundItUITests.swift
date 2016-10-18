//
//  FoundItUITests.swift
//  FoundItUITests
//
//  Created by Krishna on 09/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import XCTest

class FoundItUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        //Login Check
        
        let app = XCUIApplication()
        app.textFields["Email"].tap()
        app.textFields["Email"].typeText("demo@itsmekrish.com")
        app.secureTextFields["Password"].tap()
        app.secureTextFields["Password"].typeText("demo123456")
        app.buttons["Sign In"].tap()
        app.scrollViews.otherElements.navigationBars["Hey demo"].staticTexts["Hey demo"].tap()
        //Check if the Title has Hey Demo as title
        XCTAssertEqual((app.scrollViews.otherElements.navigationBars.element.value as! String), "Hey demo")
        
        let heyKrishNavigationBar = app.scrollViews.otherElements.navigationBars["Hey demo"]
        heyKrishNavigationBar.buttons["Found Something?"].tap()
        app.staticTexts["Display Name"].tap()
        //Check if Display Name field is visible after lanching the screen
        XCTAssert(app.staticTexts["Display Name"].isAccessibilityElement)
        
        

        
    }
    
}
