//
//  ContentView.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
    }

}


#Preview {
    ContentView().environment(\.managedObjectContext, CoreDataManager.shared.context)
}
