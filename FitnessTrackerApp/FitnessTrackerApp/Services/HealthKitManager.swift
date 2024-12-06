//
//  HealthKitManager.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import HealthKit

protocol HealthKitManagerProtocol {
    func checkHealthKitPermission()
}

class HealthKitManager: HealthKitManagerProtocol {
    static let shared = HealthKitManager()
    private let healthStore = HKHealthStore()

    // Request HealthKit permission if not granted
    private func requestHealthKitPermission() {
        guard let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Unable to access calories burned data from HealthKit.")
            return
        }
        
        // Request permission to read the calories burned data
        healthStore.requestAuthorization(toShare: [], read: [calorieType]) { success, error in
            if success {
                print("HealthKit authorization successful.")
            } else if let error = error {
                print("Error requesting HealthKit authorization: \(error.localizedDescription)")
            }
        }
    }

    // Check if HealthKit permission is granted
    func checkHealthKitPermission() {
        guard let calorieType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            print("Unable to access calories burned data from HealthKit.")
            return
        }
        
        let status = healthStore.authorizationStatus(for: calorieType)
        
        switch status {
        case .notDetermined:
            print("HealthKit permission not determined yet.")
            requestHealthKitPermission()
        case .sharingDenied:
            print("HealthKit permission denied.")
        case .sharingAuthorized:
            print("HealthKit permission granted.")
        @unknown default:
            print("Unknown HealthKit authorization status.")
        }
    }
}

