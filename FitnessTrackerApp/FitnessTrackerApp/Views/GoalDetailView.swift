//
//  GoalDetailView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import SwiftUI

struct GoalDetailView: View {
    @ObservedObject var viewModel: WorkoutsGoalsViewModel // ViewModel to manage goals
    @State private var progress: Double = 0 // Local state for progress editing
    @Binding var goal: GoalEntity? // The goal being viewed or edited
    @Environment(\.dismiss) var dismiss  // Dismiss the view when the goal is saved
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    if let goal = goal {
                        // Goal Header
                        VStack(spacing: 8) {
                            Text(goal.name ?? "Untitled Goal")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.purple)
                                .multilineTextAlignment(.center)
                            
                            Text("Target: \(goal.target, specifier: "%.2f")")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 10)
                        
                        // Circular Progress Indicator
                        ZStack {
                            Circle()
                                .trim(from: 0, to: CGFloat(progress / goal.target))
                                .stroke(progressColor, lineWidth: 20)
                                .rotationEffect(.degrees(-90))
                                .frame(width: 150, height: 150)
                            
                            VStack {
                                Text("\(Int((progress / goal.target) * 100))%")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(progressColor)
                                
                                Text("Completed")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical)
                        
                        // Slider Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Adjust Progress")
                                .font(.headline)
                            
                            Slider(value: $progress, in: 0...goal.target, step: 0.1)
                                .accentColor(.purple)
                            
                            HStack {
                                Text("0")
                                Spacer()
                                Text("\(goal.target, specifier: "%.2f")")
                            }
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        }
                        .padding()
                        
                        // Save Button
                        Button(action: {
                            updateProgress()
                        }) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title2)
                                Text("Save Progress")
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(progressColor)
                            .foregroundColor(.purple)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        // Related Workouts Section
                        if let workouts = goal.workouts as? Set<WorkoutEntity>, !workouts.isEmpty {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Workouts Related to This Goal")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                
                                ForEach(Array(workouts), id: \.self) { workout in
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(workout.name ?? "Unknown Workout")
                                                .font(.headline)
                                            Text(workout.type ?? "Unknown Type")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Text("\(workout.caloriesBurned, specifier: "%.0f") cal")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        } else {
                            Text("No related workouts for this goal.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                        
                        
                    }
                } .padding()
            }
            .navigationBarTitle("Goal Details", displayMode: .inline)
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss() // Dismiss the sheet when the cancel button is pressed
            })
            .onAppear {
                if let goal = goal {
                    progress = goal.progress // Initialize progress if goal is available
                }
            }
        }
    }
    
    // MARK: - Update Progress
    private func updateProgress() {
        guard let goal else { return }
        viewModel.updateProgress(for: goal, progress: progress)
        dismiss()
    }
    
    // MARK: - Progress Color
    private var progressColor: Color {
        guard let goal else { return .red }
        switch (progress / goal.target) {
        case 0..<0.5:
            return .red
        case 0.5..<0.8:
            return .orange
        default:
            return .green
        }
    }
}
