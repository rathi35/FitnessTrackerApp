//
//  Springboard.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//
import XCTest

class Springboard {

    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")

    class func deleteApp() {
        XCUIApplication().terminate()

        springboard.activate()
        let appIcons = springboard.icons.matching(identifier: "FitnessTrackerApp").firstMatch
        appIcons.press(forDuration: 1.3)
        
        let _ = springboard.buttons["Remove App"].waitForExistence(timeout: 1.0)
        springboard.buttons["Remove App"].tap()
        
        let deleteButton  = springboard.alerts.buttons["Delete App"].firstMatch
        if deleteButton.waitForExistence(timeout: 5) {
            deleteButton.tap()
            _ = springboard.alerts.buttons["Delete"].waitForExistence(timeout: 1.0)
            springboard.alerts.buttons["Delete"].tap()
        }
    }
 }
