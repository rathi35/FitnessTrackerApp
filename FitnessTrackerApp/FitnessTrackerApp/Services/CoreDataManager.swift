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
    func fetch<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>) throws -> [T]
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
    
    // MARK: - Fetch Data
    /// Fetch data from Core Data
    /// - Parameter request: The fetch request
    /// - Returns: An array of results
    func fetch<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>) throws -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}
