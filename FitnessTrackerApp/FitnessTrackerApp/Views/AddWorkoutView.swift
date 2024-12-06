//
//  AddWorkoutView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import SwiftUI

// AddWorkoutView is the view for adding a new workout.
struct AddWorkoutView: View {
    // Observing changes in the view model for workouts and goals
    @ObservedObject var viewModel: WorkoutsGoalsViewModel
    
    // Environment property for managing view dismissal
    @Environment(\.dismiss) var dismiss
    
    // State variables to hold form input values
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var duration: Double = 0
    @State private var caloriesBurned: Double = 0
    @State private var date: Date = Date()
    @State private var selectedGoal: GoalEntity?
    
    var body: some View {
        // Using a Form to organize the content into sections
        Form {
            // Section for workout details
            Section(header: Text("Workout Details")
                        .font(.headline)
                        .foregroundColor(.primary)) {
                TextField("Workout Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Workout Type", text: $type)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Duration (minutes)", value: $duration, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Calories Burned", value: $caloriesBurned, formatter: NumberFormatter())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Section for selecting the workout date
            Section(header: Text("Workout Date")
                        .font(.headline)
                        .foregroundColor(.primary)) {
                DatePicker("Workout Date", selection: $date, displayedComponents: .date)
            }
            
            // Section for selecting a goal associated with this workout
            Section(header: Text("Associated Goal")
                        .font(.headline)
                        .foregroundColor(.primary)) {
                Picker("Select Goal", selection: $selectedGoal) {
                    // Loop through available goals and display them in a dropdown list
                    ForEach(viewModel.goals, id: \.self) { goal in
                        Text(goal.name ?? "Unknown Goal").tag(goal as GoalEntity?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            // Button to save the workout
            Section {
                Button("Save Workout") {
                    saveWorkout()  // Call the function to save the workout
                }
                .frame(maxWidth: .infinity, alignment: .center) // Align the button in the center
            }
        }
        .navigationBarTitle("Add Workout") // Set navigation title for the view
    }

    // Function to save the workout details
    private func saveWorkout() {
        // Call the storeWorkoutInCoreData method to store workout details in Core Data
        viewModel.storeWorkoutInCoreData(
            name: name,
            type: type,
            duration: duration,
            caloriesBurned: caloriesBurned,
            date: date
        )
        
        // Optionally, you can refresh the workout list here after saving
        viewModel.fetchWorkouts()
        
        // Dismiss the current view after saving the workout
        dismiss() // Dismiss the AddWorkoutView
    }
}
