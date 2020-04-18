//
//  TriggersVC.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit
import CoreData

class TriggersVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tableData = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var fetchedResultsController: NSFetchedResultsController<Trigger>! = NSFetchedResultsController<Trigger>()
    struct TriggerDetails {
        var name: String
    }
    var triggerDetails = TriggerDetails(name: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchControllerInitializing()
        updateTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        resultSearchController.searchBar.isHidden = false;
        copyTriggerNamesToTableDataForSearching()
        updateTable()
    }
    
    func copyTriggerNamesToTableDataForSearching() {
        tableData.removeAll()
        if let vector = CoreDataManager.getArrayOfTriggerNames() {
            tableData = vector
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trigDetailsVC = segue.destination as! TriggerDetailsVC
        trigDetailsVC.triggerDetails.name = triggerDetails.name
    }
}

// MARK:- SearchBar
extension TriggersVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.tableView.reloadData()
    }
    func resultSearchControllerInitializing() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.placeholder = "Find"
            controller.searchBar.sizeToFit()
            controller.searchBar.layer.borderWidth = 1;
            controller.searchBar.layer.borderColor = UIColor.white.cgColor
            //controller.searchBar.backgroundImage = UIImage()
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
}



