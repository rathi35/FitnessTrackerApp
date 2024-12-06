//
//  ProfileView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                if let currentUser = Auth.auth().currentUser {
                    if let photoURL = currentUser.photoURL  {
                        AsyncImage(url: photoURL)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.purple)
                            .padding(.top)
                    }
                    if let displayName = currentUser.displayName {
                        Text(displayName)
                            .font(.title)
                            .bold()
                    }
                    Text(currentUser.email ?? "Email not available")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                } else {
                    Text("No user information available")
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                Button(action: {
                    showLogoutAlert = true
                }) {
                    Text("Logout")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("Logout"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Logout")) {
                            authViewModel.signOut()
                        },
                        secondaryButton: .cancel()
                    )
                }
                
                Spacer()
            }
            .navigationTitle("Profile")
            .onAppear() {
                authViewModel.errorMessage = ""
            }
        }
    }
}
