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
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isAuthenticated {
            Button("Logout") {
                    viewModel.signOut()
                }
            } else {
                LoginView(authViewModel: viewModel)  // Show LoginView if not authenticated
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.context)
}
