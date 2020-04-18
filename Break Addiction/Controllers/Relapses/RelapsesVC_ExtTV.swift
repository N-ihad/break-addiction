//
//  RelapsesVC_ExtTV.swift
//  Break Addiction
//
//  Created by Nihad on 4/17/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit
import CoreData

var fetchedResultsController: NSFetchedResultsController<Relapse>! = NSFetchedResultsController<Relapse>()
var indPath: IndexPath = [0, 0]

extension RelapsesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive{
            return filteredTableData.count
        } else {
            return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //cell.textLabel?.font = UIFont(name: "Lato", size: 15.0)
        let relapseDate = CoreDataManager.convertDateToString(date: fetchedResultsController.object(at: indexPath).whenItHappened)
        if resultSearchController.isActive {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        } else {
            cell.textLabel?.text = relapseDate
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive {
            let selectedRelapse = tableView.cellForRow(at: indexPath)!.textLabel!.text!
            let relapseObj = fetchedResultsController.fetchedObjects!.first(where: {CoreDataManager.convertDateToString(date: $0.whenItHappened) == selectedRelapse})!
            indPath = fetchedResultsController.indexPath(forObject: relapseObj)!
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "relapseDetailsSegue", sender: self)
                self.resultSearchController.isActive = false
            }
        }
        else {
            indPath = indexPath
            performSegue(withIdentifier: "relapseDetailsSegue", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let triggerName = tableView.cellForRow(at: indexPath)!.textLabel!.text!
            //appDelegate.coreDataManager.deleteTriggerWithName(name: triggerName)
        }
        copyRelapseDatesToTableDataForSearching()
        self.updateTable()
    }
    
    func updateTable() {
        let request = NSFetchRequest<Relapse>(entityName: "Relapse")
        request.sortDescriptors = [NSSortDescriptor(key: "whenItHappened", ascending: false)]
        //let sort = NSSortDescriptor(key: "name", ascending: true)
        //request.sortDescriptors = [sort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error loading data \(error)")
        }
        tableView.reloadData()
    }
}
