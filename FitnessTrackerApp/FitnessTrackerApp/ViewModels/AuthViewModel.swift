//
//  AuthViewModel.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI
import FirebaseAuth

protocol FirebaseManagerProtocol {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() throws
    func isLoggedIn() -> Bool
}

@MainActor
class AuthViewModel: ObservableObject {
    var isAuthenticated: Bool {
        firebaseManager.isLoggedIn()
    }
    @Published var errorMessage: String? = nil

    private let firebaseManager: FirebaseManagerProtocol
    
    init(firebaseManager: FirebaseManagerProtocol = FirebaseManager.shared) {
        self.firebaseManager = firebaseManager
    }

    /// Logs in a user
    func signIn(email: String, password: String) async {
        do {
            try await firebaseManager.signIn(email: email, password: password)
        } catch {
            handleAuthError(error)
        }
    }

    /// Signs up a new user
    func signUp(email: String, password: String) async {
        do {
            try await firebaseManager.signUp(email: email, password: password)
        } catch {
            handleAuthError(error)
        }
    }

    /// Logs out the current user
    func signOut() {
        do {
            try firebaseManager.signOut()
        } catch {
            handleAuthError(error)
        }
    }

    
    // Error handling method to handle Firebase error codes
    private func handleAuthError(_ error: Error) {
        let authError = error as NSError
        switch authError.code {
        case AuthErrorCode.userNotFound.rawValue:
            errorMessage = "User not found. Please check your email address."
        case AuthErrorCode.wrongPassword.rawValue:
            errorMessage = "Incorrect password. Please try again."
        case AuthErrorCode.invalidEmail.rawValue:
            errorMessage = "The email address is invalid."
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            errorMessage = "The email address is already in use by another account."
        case AuthErrorCode.networkError.rawValue:
            errorMessage = "Network error. Please try again later."
        case AuthErrorCode.invalidCredential.rawValue:
            errorMessage = "Invalid credentials, please check your email/password."
        default:
            errorMessage = "An error occurred. Please try again."
        }
    }
}