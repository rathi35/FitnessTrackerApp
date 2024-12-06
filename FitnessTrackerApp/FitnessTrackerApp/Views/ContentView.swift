//
//  ContentView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var authViewModel = AuthViewModel()

    @State private var isSplashScreenVisible = true // State to control splash screen visibility
    
    var body: some View {
        ZStack {
            // Main content: Either DashboardView or LoginView based on authentication status
            NavigationView {
                if authViewModel.isAuthenticated {
                    DashboardView(authViewModel: authViewModel)
                } else {
                    LoginView(authViewModel: authViewModel) // Show LoginView if not authenticated
                }
            }
            .zIndex(0)  // Main content behind splash screen

            // Show splash screen while isSplashScreenVisible is true
            if isSplashScreenVisible {
                SplashScreenView()
                    .zIndex(1)  // Make splash screen appear on top
            }
        }
        .onAppear {
            // Check if user is authenticated when app starts
            authViewModel.isAuthenticated = Auth.auth().currentUser != nil
            
            // Simulate a delay for splash screen (e.g., for fetching initial data)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2-second delay
                // Hide splash screen and show the content
                withAnimation {
                    isSplashScreenVisible = false
                }
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.context)
}
