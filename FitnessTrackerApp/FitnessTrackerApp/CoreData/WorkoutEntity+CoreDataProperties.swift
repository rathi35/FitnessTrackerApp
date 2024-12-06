//
//  WorkoutEntity+CoreDataProperties.swift
//  
//
//  Created by Rathi Shetty on 05/12/24.
//
//

import Foundation
import CoreData


extension WorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEntity> {
        return NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
    }

    @NSManaged public var caloriesBurned: Double
    @NSManaged public var date: Date?
    @NSManaged public var duration: Double
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var goal: GoalEntity?

}
