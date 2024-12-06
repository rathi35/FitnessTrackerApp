//
//  WorkoutsView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import SwiftUI

/// A view to display the list of workouts and allow the user to add a new workout.
struct WorkoutsView: View {
    /// The ViewModel responsible for managing workout data
    @ObservedObject var workoutsViewModel: WorkoutsGoalsViewModel
    
    /// State to control whether the "Add Workout" sheet is visible
    @State private var showingAddWorkout = false
    
    var body: some View {
        // Wrap the content in a NavigationView to enable navigation bar features
        NavigationView {
            VStack {
                // Check if there are any workouts
                if workoutsViewModel.workouts.isEmpty {
                    // Show a message if no workouts are found
                    Text("No workouts available.")
                        .font(.headline)
                        .padding()
                    
                    // Button to prompt the user to add a workout
                    Button(action: {
                        showingAddWorkout.toggle()  // Show the "Add Workout" sheet
                    }) {
                        Text("Add Your First Workout")
                            .font(.body)
                            .foregroundColor(.blue)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    }
                } else {
                    // Display a list of workouts if available
                    List(workoutsViewModel.workouts) { workout in
                        VStack(alignment: .leading) {
                            // Workout Name
                            Text(workout.name ?? "Unnamed Workout")
                                .font(.headline)
                            
                            // Workout Type
                            Text("Type: \(workout.type ?? "Unknown")")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            // Workout Duration
                            Text("Duration: \(workout.duration) minutes")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            // Calories Burned
                            Text("Calories Burned: \(workout.caloriesBurned) kcal")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            // Workout Date (Formatted)
                            Text("Date: \(formattedDate(workout.date ?? Date()))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8) // Add vertical padding to each item
                    }
                    .listStyle(PlainListStyle()) // Remove default list style
                }
            }
            // Set the navigation bar title to "Workouts"
            .navigationBarTitle("Workouts")
            
            // Add a "Add Workout" button in the top-right corner of the navigation bar
            .navigationBarItems(trailing: Button("Add Workout") {
                // Toggle the state to show the "Add Workout" sheet
                showingAddWorkout.toggle()
            })
            
            // Show the "AddWorkoutView" sheet when `showingAddWorkout` is true
            .sheet(isPresented: $showingAddWorkout) {
                // Pass the ViewModel to the AddWorkoutView
                AddWorkoutView(viewModel: workoutsViewModel)
            }
            
            // Button to add a new goal
            Button(action: {
                showingAddWorkout.toggle()
            }) {
                Text("Add New Goal")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
            }
            .padding()
            .sheet(isPresented: $showingAddWorkout) {
                // Pass the ViewModel to the AddWorkoutView
                AddWorkoutView(viewModel: workoutsViewModel)
            }
        }
    }
    
    /// Formats the date to a more readable string (e.g., "December 5, 2024").
    /// - Parameter date: The date to be formatted.
    /// - Returns: A formatted string representation of the date.
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
}

