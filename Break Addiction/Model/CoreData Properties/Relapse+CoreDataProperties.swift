//
//  Relapse+CoreDataProperties.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//
//

import Foundation
import CoreData


extension Relapse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Relapse> {
        return NSFetchRequest<Relapse>(entityName: "Relapse")
    }

    @NSManaged public var whenItHappened: Date
    @NSManaged public var whyItHappened: String?
    @NSManaged public var place: String?
    @NSManaged public var streak: String
    @NSManaged public var trigger: Trigger?

}
