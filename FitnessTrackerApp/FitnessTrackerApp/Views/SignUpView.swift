//
//  SignUpView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Fitness Tracking")
                .font(.title)
                .foregroundColor(.purple)
                .padding(20)
            Spacer()
            
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textContentType(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textContentType(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Button(action: {
                Task {
                    guard password == confirmPassword else {
                        authViewModel.errorMessage = "Passwords do not match."
                        return
                    }
                    isLoading = true
                    await authViewModel.signUp(email: email, password: password)
                    isLoading = false
                }
            }) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Sign Up")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            Button("Already have an account? Login") {
                dismiss()
            }
            .padding()
            .foregroundColor(.purple)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            authViewModel.errorMessage = ""
        }
    }
}
