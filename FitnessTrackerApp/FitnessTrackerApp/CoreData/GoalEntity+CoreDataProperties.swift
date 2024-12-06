//
//  GoalEntity+CoreDataProperties.swift
//  
//
//  Created by Rathi Shetty on 05/12/24.
//
//

import Foundation
import CoreData


extension GoalEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalEntity> {
        return NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var progress: Double
    @NSManaged public var target: Double
    @NSManaged public var updatedAt: Date?
    @NSManaged public var workouts: WorkoutEntity?

}

// MARK: Generated accessors for workouts
extension GoalEntity {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: WorkoutEntity)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: WorkoutEntity)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}
