//
//  FirebaseManager.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import Foundation
import FirebaseAuth

protocol FirebaseManagerProtocol {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() throws
    func isLoggedIn() -> Bool
    func getUserEmail() -> String?
}

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
    
    func getUserEmail() -> String? {
        return Auth.auth().currentUser?.email
    }
}
