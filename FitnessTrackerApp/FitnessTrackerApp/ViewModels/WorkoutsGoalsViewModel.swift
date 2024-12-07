//
//  WorkoutsGoalsViewModel.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import Foundation
import Combine
import CoreData
import HealthKit

/// A view model for managing workouts and goals with HealthKit integration.
@MainActor
class WorkoutsGoalsViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var workouts: [WorkoutEntity] = [] // List of workouts
    @Published var goals: [GoalEntity] = [] // List of goals
    @Published var errorMessage: String? = nil // To display error messages
    @Published var isLoading: Bool = false // Loading state
    @Published var progress: Double = 0 // Total progress across goals

    // MARK: - Dependencies
    private let coreDataManager: CoreDataManagerProtocol
    private let authViewModel: AuthViewModel
    private let healthKitManager: HealthKitManager

    // MARK: - Combine Subscriptions
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Initializer
    init(coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared,
         authViewModel: AuthViewModel,
         healthKitManager: HealthKitManager = .shared) {
        self.coreDataManager = coreDataManager
        self.authViewModel = authViewModel
        self.healthKitManager = healthKitManager
        
        // Observe changes in authentication state
        authViewModel.$isAuthenticated
            .sink { [weak self] isAuthenticated in
                guard let self = self else { return }
                if isAuthenticated {
                    self.fetchWorkouts()
                    self.fetchGoals()
                } else {
                    self.clearData()
                }
            }
            .store(in: &cancellables)

        // Fetch data if the user is already authenticated
        if authViewModel.isAuthenticated {
            fetchWorkouts()
            fetchGoals()
        }
    }
    
    // MARK: - Method to Update Progress for a Goal
    func updateProgress(for goal: GoalEntity, progress: Double) {
        goal.progress = progress
        goal.updatedAt = Date() // Update timestamp
        do {
            try coreDataManager.save() // Save to Core Data
            fetchGoals() // Refresh goals after update
        } catch {
            errorMessage = "Failed to update goal progress: \(error.localizedDescription)"
        }
    }

    // MARK: - Fetch Workouts
    func fetchWorkouts() {
        guard let email = authViewModel.currentUserEmail else {
            errorMessage = "User email is unavailable."
            return
        }
        isLoading = true
        
        // Fetch workouts associated with the authenticated user
        workouts = coreDataManager.fetchWorkouts(for: email)
        
        // If no workouts are found or an error occurs, update the error message
        if workouts.isEmpty {
            errorMessage = "No workouts found for the current user."
        } else {
            errorMessage = nil // Clear any previous error messages
        }
        
        isLoading = false
    }


    // MARK: - Fetch Goals
    func fetchGoals() {
        guard let email = authViewModel.currentUserEmail else { return }
        isLoading = true
        
        // Fetch goals associated with the authenticated user
        goals = coreDataManager.fetchGoals(for: email)
        
        // If no goals are found or an error occurs, update the error message
        if goals.isEmpty {
            errorMessage = "No goals found for the current user."
        } else {
            errorMessage = nil // Clear any previous error messages
        }
        
        isLoading = false
    }


    // MARK: - Add New Goal
    func addGoal(name: String, target: Double, selectedWorkouts: [WorkoutEntity]) {
        let newGoal = GoalEntity(context: coreDataManager.context)
        newGoal.id = UUID()
        newGoal.name = name
        newGoal.target = target
        newGoal.progress = 0
        newGoal.updatedAt = Date()
        newGoal.addToWorkouts(NSSet(array: selectedWorkouts))
        newGoal.email = authViewModel.currentUserEmail // Associate with the current user
        
        do {
            try coreDataManager.save()
            fetchGoals()
        } catch {
            errorMessage = "Failed to save goal: \(error.localizedDescription)"
        }
    }

    // MARK: - Add New Workout
    func storeWorkoutInCoreData(name: String, type: String, duration: Double, caloriesBurned: Double, date: Date) {
        let workout = WorkoutEntity(context: coreDataManager.context)
        workout.id = UUID()
        workout.name = name
        workout.type = type
        workout.duration = duration
        workout.caloriesBurned = caloriesBurned
        workout.date = date
        workout.email = authViewModel.currentUserEmail // Associate with the current user
        
        do {
            try coreDataManager.save()
            fetchWorkouts()
        } catch {
            errorMessage = "Failed to save workout: \(error.localizedDescription)"
        }
    }

    // MARK: - Request HealthKit Permissions
    func requestHealthKitPermission() {
        healthKitManager.checkHealthKitPermission()
    }
    
    // MARK: - Delete a Goal
    func deleteGoal(_ goal: GoalEntity) {
        coreDataManager.context.delete(goal) // Remove the goal from Core Data
        do {
            try coreDataManager.save() // Persist changes
            fetchGoals() // Refresh the goals list
        } catch {
            errorMessage = "Failed to delete goal: \(error.localizedDescription)"
        }
    }

    // MARK: - Clear All Data
    private func clearData() {
        workouts.removeAll()
        goals.removeAll()
        progress = 0
    }
}
