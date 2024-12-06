//
//  AddGoalView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//
import SwiftUI

struct AddGoalView: View {
    @ObservedObject var viewModel: WorkoutsGoalsViewModel
    @Binding var showAddGoalSheet: Bool // Binding to control the sheet visibility
    
    @State private var goalName: String = ""
    @State private var target: String = ""
    @State private var selectedWorkouts: [WorkoutEntity] = []
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Goal Details")) {
                    TextField("Goal Name", text: $goalName)
                        .autocapitalization(.words)
                        .padding()
                    
                    TextField("Target", text: $target)
                        .keyboardType(.decimalPad)
                        .padding()
                }
                
                Section(header: Text("Select Workouts")) {
                    List(viewModel.workouts, id: \.self) { workout in
                        HStack {
                            Text(workout.name ?? "Unnamed Workout")
                            Spacer()
                            if selectedWorkouts.contains(workout) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle()) // Make the entire row tappable
                        .onTapGesture {
                            if let index = selectedWorkouts.firstIndex(of: workout) {
                                selectedWorkouts.remove(at: index) // Deselect workout
                            } else {
                                selectedWorkouts.append(workout) // Select workout
                            }
                        }
                    }
                }

                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    addGoal()
                }) {
                    Text("Save Goal")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(goalName.isEmpty || target.isEmpty || selectedWorkouts.isEmpty)
            }
            .navigationTitle("Add New Goal")
            .navigationBarItems(trailing: Button("Cancel") {
                showAddGoalSheet = false // Dismiss the sheet on cancel
            })
        }
    }
    
    // MARK: - Add Goal
    private func addGoal() {
        guard let targetValue = Double(target) else {
            errorMessage = "Please enter a valid target number."
            return
        }
        
        // Add the goal using the ViewModel
        viewModel.addGoal(name: goalName, target: targetValue, selectedWorkouts: selectedWorkouts)
        
        // Dismiss the sheet after saving the goal
        showAddGoalSheet = false
    }
}

struct AddGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddGoalView(viewModel: WorkoutsGoalsViewModel(authViewModel: AuthViewModel()), showAddGoalSheet: .constant(true))
    }
}
