//
//  MockFirebaseManager.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import Foundation

class MockFirebaseManager: FirebaseManagerProtocol {
    var shouldFail = false

    func signIn(email: String, password: String) async throws {
        if shouldFail {
            throw NSError(domain: "MockError", code: 17004, userInfo: [NSLocalizedDescriptionKey: "Invalid credentials, please check your email/password."])
        }
    }

    func signUp(email: String, password: String) async throws {
        if shouldFail {
            throw NSError(domain: "MockError", code: 17007, userInfo: [NSLocalizedDescriptionKey: "Email already in use"])
        }
    }

    func signOut() throws {
        if shouldFail {
            throw NSError(domain: "MockError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Sign-out failed"])
        }
    }

    func isLoggedIn() -> Bool {
        return !shouldFail
    }
}
