//
//  LoginView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Fitness Tracking")
                .font(.title)
                .foregroundColor(.purple)
                .padding(20)
            Spacer()
            
            Text("Login")
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
                    isLoading = true
                    await authViewModel.signIn(email: email, password: password)
                    isLoading = false
                }
            }) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Login")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            
            NavigationLink("Don't have an account? Sign Up", destination: SignUpView(authViewModel: authViewModel))
                .padding()
                .foregroundColor(.purple)
            
            Spacer()
        }
    }
}
