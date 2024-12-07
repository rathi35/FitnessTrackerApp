//
//  CoreDataManager.swift
//  FitnessTrackerApp
//
//  Created by Rathi Shetty on 04/12/24.
//
import Foundation
import CoreData

/// Protocol to define Core Data operations
protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    func save() throws
    func fetchWorkouts(for email: String) -> [WorkoutEntity]
    func fetchGoals(for email: String) -> [GoalEntity]
}

/// Manages Core Data stack and operations
final class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    
    // MARK: - Persistent Container
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FitnessTrackerApp")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Contexts
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Data
    /// Save changes to the context
    func save() throws {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    // Fetch workouts for a specific email
    func fetchWorkouts(for email: String) -> [WorkoutEntity] {
        let fetchRequest: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching workouts: \(error.localizedDescription)")
            return []
        }
    }
    
    // Fetch goals for a specific email
    func fetchGoals(for email: String) -> [GoalEntity] {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching goals: \(error.localizedDescription)")
            return []
        }
    }
}
