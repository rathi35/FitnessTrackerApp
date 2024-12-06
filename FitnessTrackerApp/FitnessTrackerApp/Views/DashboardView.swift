//
//  DashboardView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import SwiftUI

/// A tab view that organizes the app's main features: Workouts, Progress, Goals, and Profile.
struct DashboardView: View {
    
    @StateObject var authViewModel: AuthViewModel // AuthViewModel to manage authentication state
    @StateObject var workoutsGoalsViewModel: WorkoutsGoalsViewModel // ViewModel to manage workout data
    
    // Initialize with AuthViewModel
    init(authViewModel: AuthViewModel) {
        _authViewModel = StateObject(wrappedValue: authViewModel)
        _workoutsGoalsViewModel = StateObject(wrappedValue: WorkoutsGoalsViewModel(authViewModel: authViewModel)) // Initialize WorkoutsGoalsViewModel with AuthViewModel
    }
    
    var body: some View {
        TabView {
            // Workouts Tab
            WorkoutsView(workoutsViewModel: workoutsGoalsViewModel)
                .tabItem {
                    Image(systemName: "flame")
                    Text("Workouts")
                }
            
            // Goals Tab
            GoalsView(viewModel: workoutsGoalsViewModel)
                .tabItem {
                    Label("Goals", systemImage: "star.fill")
                }
            
            // Profile Tab
            ProfileView(authViewModel: authViewModel)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .onAppear {
            workoutsGoalsViewModel.requestHealthKitPermission() // Request permission when the view appears
        }
        .onChange(of: authViewModel.isAuthenticated) { isAuthenticated in
            if !isAuthenticated {
                
            }
        }
    }
}
