//
//  SpeedometerUITests.swift
//  SpeedometerUITests
//
//  Created by Mark DiFranco on 4/3/17.
//  Copyright © 2017 Mark DiFranco. All rights reserved.
//

import XCTest

class SpeedometerUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app.launchArguments = ["UITests"]
        app.launch()
    }
    
    func test_maximumSpeed_setMaximumSpeed() {
        let locationAlert = app.alerts["Location Authorization"]
        waitForExistence(of: locationAlert)
        locationAlert.buttons["Allow"].tap()
        
        let blueLabel = app.otherElements["SpeedLabelBlue"]
        XCTAssertEqual("0", blueLabel.label)
        
        app.buttons["Max Speed"].tap()
        
        let maxSpeedAlert = app.alerts["Pick a max speed"]
        waitForExistence(of: maxSpeedAlert)
        
        let textField = maxSpeedAlert.collectionViews.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("40")
        maxSpeedAlert.buttons["OK"].tap()
        
        let whiteLabel = app.otherElements["SpeedLabelWhite"]
        XCTAssertEqual("72", whiteLabel.label)
        
        let backgroundView = app.otherElements["RootView"]
        let speedView = app.otherElements["SpeedView"]
        
        XCTAssertEqual(backgroundView.frame.height, speedView.frame.height * 2)
    }
    
    func test_authorization_denied_presentInstructionsToUser() {
        let locationAlert = app.alerts["Location Authorization"]
        waitForExistence(of: locationAlert)
        locationAlert.buttons["Don't Allow"].tap()
        
        let deniedAlert = app.alerts["Permission Denied"]
        waitForExistence(of: deniedAlert)
        deniedAlert.buttons["OK"].tap()
    }
    
}

extension XCTestCase {
    
    func waitForExistence(of element: XCUIElement, file: String = #file, line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == true")
        expectation(for: predicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: 3) { (error) in
            guard error != nil else { return }
            
            let description = "\(element) does not exist after 3 seconds."
            self.recordFailure(withDescription: description, inFile: file, atLine: line, expected: true)
        }
    }
}










