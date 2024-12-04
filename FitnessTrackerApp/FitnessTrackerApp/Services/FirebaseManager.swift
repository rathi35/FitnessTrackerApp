//
//  FirebaseManager.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import Foundation
import FirebaseAuth

class FirebaseManager: FirebaseManagerProtocol {
    static let shared = FirebaseManager()

    private init() {}

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signUp(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    func isLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
}