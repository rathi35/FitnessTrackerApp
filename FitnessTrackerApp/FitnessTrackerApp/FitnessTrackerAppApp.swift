//
//  FitnessTrackerAppApp.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI

@main
struct FitnessTrackerAppApp: App {
    private let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.context)
        }
    }
}
