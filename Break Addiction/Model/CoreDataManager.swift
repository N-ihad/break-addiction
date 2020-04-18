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
    
    static func convertDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
    
    static func relapsed(on date: Date, with trigger: String, _ place: String, and ownExplanation: String) {
        if let addiction = fetchAddictionEntity() {
            let relapse = Relapse(context: context)
            let place = place.isEmpty ? nil : place
            let ownExplanation = ownExplanation.isEmpty ? nil : ownExplanation
            
            
            if !trigger.isEmpty {
                let trig = Trigger(context: context)
                trig.name = trigger
                relapse.trigger = trig
                addiction.triggers?.insert(trig)
            }
            
            relapse.place = place
            relapse.whyItHappened = ownExplanation
            relapse.whenItHappened = date
            
            let difference = Calendar.current.dateComponents([.day, .hour, .minute], from: addiction.abstainingStartDate, to: Date())
            relapse.streak = String(difference.day!) + " days " + String(difference.hour!) + " hours " + String(difference.minute!) + " minutes "
            
            addiction.relapses?.insert(relapse)
            addiction.abstainingStartDate = Date()
            
        } else {print("Error accessing the database to add a relapse object")}
    }
    
    static func getArrayOfTriggerNames() -> [String]? {
        if let addiction = fetchAddictionEntity() {
            var resultArray = [String]()
            for eachEl in addiction.triggers! {
                resultArray.append(eachEl.name!)
            }
            return resultArray.sorted()
        } else {
            print("Error accessing the database to get an array of trigger names for copying")
            return nil
        }
    }
    
    static func getArrayOfRelapseDates() -> [String]? {
        if let addiction = fetchAddictionEntity() {
            var resultArray = [String]()
            for eachEl in addiction.relapses! {
                resultArray.append(convertDateToString(date: eachEl.whenItHappened))
            }
            return resultArray.sorted()
        } else {
            print("Error accessing the database to get an array of relapse dates for copying")
            return nil
        }
    }
    
    static func deleteRelapse(relapseObj: Relapse) {
        context.delete(relapseObj)
        saveContext()
    }
    
    static func fetchAddictionEntity() -> Addiction? {
        let fetchRequest: NSFetchRequest<Addiction> = Addiction.fetchRequest()
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
