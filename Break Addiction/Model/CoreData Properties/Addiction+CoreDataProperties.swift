//
//  Addiction+CoreDataProperties.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//
//

import Foundation
import CoreData


extension Addiction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Addiction> {
        return NSFetchRequest<Addiction>(entityName: "Addiction")
    }

    @NSManaged public var name: String
    @NSManaged public var abstainingStartDate: Date
    @NSManaged public var relapses: Set<Relapse>?
    @NSManaged public var triggers: Set<Trigger>?

}

// MARK: Generated accessors for relapses
extension Addiction {

    @objc(addRelapsesObject:)
    @NSManaged public func addToRelapses(_ value: Relapse)

    @objc(removeRelapsesObject:)
    @NSManaged public func removeFromRelapses(_ value: Relapse)

    @objc(addRelapses:)
    @NSManaged public func addToRelapses(_ values: NSSet)

    @objc(removeRelapses:)
    @NSManaged public func removeFromRelapses(_ values: NSSet)

}

// MARK: Generated accessors for triggers
extension Addiction {

    @objc(addTriggersObject:)
    @NSManaged public func addToTriggers(_ value: Trigger)

    @objc(removeTriggersObject:)
    @NSManaged public func removeFromTriggers(_ value: Trigger)

    @objc(addTriggers:)
    @NSManaged public func addToTriggers(_ values: NSSet)

    @objc(removeTriggers:)
    @NSManaged public func removeFromTriggers(_ values: NSSet)

}
