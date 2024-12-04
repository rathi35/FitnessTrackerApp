//
//  AppDelegate.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Other initialization code
        return true
    }

    // Other methods
}
