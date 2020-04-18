//
//  TriggersVC_ExtTV.swift
//  Break Addiction
//
//  Created by Nihad on 4/18/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit
import CoreData


extension TriggersVC: UITableViewDelegate, UITableViewDataSource {
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
        let trigName = fetchedResultsController.object(at: indexPath).name
        if resultSearchController.isActive {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        } else {
            cell.textLabel?.text = trigName
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if resultSearchController.isActive {
            return UITableViewCell.EditingStyle.none
        } else {
            return UITableViewCell.EditingStyle.delete
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTrigger = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        //let relapseObj = fetchedResultsController.fetchedObjects!.first(where: {CoreDataManager.convertDateToString(date: $0.whenItHappened) == selectedRelapse})!
        triggerDetails.name = selectedTrigger
        if resultSearchController.isActive {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "triggerDetailsSegue", sender: self)
                self.resultSearchController.searchBar.isHidden = true;
                self.resultSearchController.isActive = false
            }
        } else {
            performSegue(withIdentifier: "triggerDetailsSegue", sender: self)
        }
    }
    
    func updateTable() {
        let request = NSFetchRequest<Trigger>(entityName: "Trigger")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error loading data \(error)")
        }
        tableView.reloadData()
    }
}
