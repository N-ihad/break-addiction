//
//  CoreDataManager.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Break_Addiction")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func setAddiction(with name: String) {
        let addiction = Addiction(context: context)
        addiction.name = name
        addiction.abstainingStartDate = Date()
//        print(addiction.abstainingStartDate.description(with: .current))
//        let formatter = DateFormatter()
//        formatter.timeZone = TimeZone.current
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        let dateString = formatter.string(from: addiction.abstainingStartDate)
//        print(dateString)
    }
    
    static func fetchAddictionEntity() -> Addiction? {
        let fetchRequest = Addiction.notAmbiguousFetchRequest()
        if let fetchedData = try? context.fetch(fetchRequest) {
            if fetchedData.count > 0 {
                return fetchedData[0]
            } else {
                print("Addiction has not been set yet")
                return nil
            }
        } else {
            print("Error fetching addiction")
            return nil
        }
    }
    
}
