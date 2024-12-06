//
//  AuthViewModelTests.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import XCTest
import Firebase

@MainActor
class AuthViewModelTests: XCTestCase {
    var viewModel: AuthViewModel!
    var mockFirebaseManager: MockFirebaseManager!

    override func setUp() {
        super.setUp()
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        mockFirebaseManager = MockFirebaseManager()
        viewModel = AuthViewModel(firebaseManager: mockFirebaseManager)
    }

    override func tearDown() {
        viewModel = nil
        mockFirebaseManager = nil
        super.tearDown()
    }

    func testSignInSuccess() async {
        mockFirebaseManager.shouldFail = false

        await viewModel.signIn(email: "test@example.com", password: "password")
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testSignInFailure() async {
        mockFirebaseManager.shouldFail = true

        await viewModel.signIn(email: "test@example.com", password: "password")
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertEqual(viewModel.errorMessage, "Invalid credentials, please check your email/password.")
    }

    func testSignUpSuccess() async {
        mockFirebaseManager.shouldFail = false

        await viewModel.signUp(email: "newuser@example.com", password: "password")
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testSignUpFailure() async {
        mockFirebaseManager.shouldFail = true

        await viewModel.signUp(email: "existing@example.com", password: "password")
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertEqual(viewModel.errorMessage, "The email address is already in use by another account.")
    }
    
    func testssignOutSuccess() async {
        mockFirebaseManager.shouldFail = false
        
        viewModel.signOut()
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testssignOutFailure() async {
        mockFirebaseManager.shouldFail = true
        
        viewModel.signOut()
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertEqual(viewModel.errorMessage, "An error occurred. Please try again.")
    }
}
