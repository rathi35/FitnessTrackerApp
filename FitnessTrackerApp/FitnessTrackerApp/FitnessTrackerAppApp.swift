//
//  FitnessTrackerAppApp.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI
import Firebase

@main
struct FitnessTrackerAppApp: App {
    private let coreDataManager = CoreDataManager.shared

    // Initialize Firebase when the app starts
    init() {
        FirebaseApp.configure() // Ensure Firebase is configured first
        Analytics.logEvent("app_launch", parameters: nil)  // Log app launch event
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
