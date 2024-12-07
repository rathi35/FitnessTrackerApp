//
//  GoalsView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 05/12/24.
//

import SwiftUI

struct GoalsView: View {
    @ObservedObject var viewModel: WorkoutsGoalsViewModel
    @State private var showAddGoalSheet = false
    @State private var showGoalDetail = false
    @State private var selectedGoal: GoalEntity?

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.goals.isEmpty {
                    placeholderView
                } else {
                    List {
                        ForEach(viewModel.goals, id: \.objectID) { goal in
                            Button(action: {
                                selectedGoal = goal
                                showGoalDetail.toggle()
                            }) {
                                GoalRow(goal: goal)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    viewModel.deleteGoal(goal)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Goals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddGoalSheet.toggle() }) {
                        Label("Add Goal", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddGoalSheet) {
                AddGoalView(viewModel: viewModel, showAddGoalSheet: $showAddGoalSheet)
            }
            .sheet(isPresented: $showGoalDetail) {
                    GoalDetailView(viewModel: viewModel, goal: $selectedGoal)
            }
            .onAppear {
                selectedGoal = viewModel.goals.first
            }
        }
    }

    /// Placeholder view for when no goals are available
    private var placeholderView: some View {
        Text("No goals available. Add a new goal!")
            .foregroundColor(.gray)
            .padding()
    }

}
