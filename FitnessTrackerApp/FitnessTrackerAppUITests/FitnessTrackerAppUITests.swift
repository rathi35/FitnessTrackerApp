//
//  FitnessTrackerAppUITests.swift
//  FitnessTrackerAppUITests
//
//  Created by Rathi Shetty on 04/12/24.
//

import XCTest

final class FitnessAppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        Springboard.deleteApp()
        super.tearDown()
    }
    
    func testLoginSuccess() {
        // Navigate to Login Screen
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        
        // Enter valid credentials
        emailField.tap()
        emailField.typeText("test@example.com")
        
        passwordField.tap()
        passwordField.typeText("password")
        
        loginButton.tap()
        
        let _ = app.buttons["Logout"].waitForExistence(timeout: 1.0)
        
        // Verify successful login (e.g., navigating to the main app view)
        XCTAssertTrue(app.buttons["Logout"].exists)
    }
    
    func testLoginFailure() {
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let loginButton = app.buttons["Login"]
        
        // Enter invalid credentials
        emailField.tap()
        emailField.typeText("wrong@example.com")
        
        passwordField.tap()
        passwordField.typeText("wrongpassword")
        
        loginButton.tap()
        
        sleep(1)
        
        // Verify error message
        let errorMessage = app.staticTexts["Invalid credentials, please check your email/password."]
        XCTAssertTrue(errorMessage.exists)
    }
    
    func testSignUpSuccess() {
        // Navigate to SignUp Screen
        app.buttons["Don't have an account? Sign Up"].tap()
        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let confirmPasswordField = app.secureTextFields["Confirm Password"]
        let signUpButton = app.buttons["Sign Up"]
        
        // Enter valid details
        emailField.tap()
        emailField.typeText("newuser5@example.com")
        
        passwordField.tap()
        passwordField.typeText("password")
        
        confirmPasswordField.tap()
        confirmPasswordField.typeText("password")
        
        signUpButton.tap()
        
        sleep(3)
        
        // Verify successful sign-up (e.g., navigating to the main app view)
        XCTAssertTrue(app.buttons["Logout"].exists)
    }
    
    func testSignUpFailure() {
        app.buttons["Don't have an account? Sign Up"].tap()
        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let confirmPasswordField = app.secureTextFields["Confirm Password"]
        let signUpButton = app.buttons["Sign Up"]
        
        // Enter invalid details (e.g., mismatched passwords)
        emailField.tap()
        emailField.typeText("newuser@example.com")
        
        passwordField.tap()
        passwordField.typeText("password")
        
        confirmPasswordField.tap()
        confirmPasswordField.typeText("differentpassword")
        
        signUpButton.tap()
        
        // Verify error message
        let errorMessage = app.staticTexts["Passwords do not match."]
        XCTAssertTrue(errorMessage.exists)
    }
}
