//
//  GoalRow.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 06/12/24.
//

import SwiftUI

struct GoalRow: View {
    let goal: GoalEntity // The goal to display

    var body: some View {
        HStack {
            // Progress Circle
            ZStack {
                Circle()
                    .stroke(lineWidth: 8)
                    .opacity(0.3)
                    .foregroundColor(.purple)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(goal.progress / goal.target, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.purple)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.easeInOut, value: goal.progress)
                Text("\(Int(min(goal.progress / goal.target, 1.0) * 100))%")
                    .font(.caption)
                    .bold()
            }
            .frame(width: 50, height: 50)
            .padding(.trailing, 8)

            // Goal Details
            VStack(alignment: .leading, spacing: 4) {
                Text(goal.name ?? "Unnamed Goal")
                    .font(.headline)
                HStack {
                    Text("Progress:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(Int(goal.progress))/\(Int(goal.target))")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }

            Spacer()
        }
        .padding()
    }
}
