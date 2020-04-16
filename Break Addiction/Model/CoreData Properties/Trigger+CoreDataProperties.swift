//
//  Trigger+CoreDataProperties.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//
//

import Foundation
import CoreData


extension Trigger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trigger> {
        return NSFetchRequest<Trigger>(entityName: "Trigger")
    }

    @NSManaged public var name: String?

}
