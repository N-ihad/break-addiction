//
//  SecondViewController.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit
import CoreData

class RelapsesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tableData = [String]()
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    var fetchedResultsController: NSFetchedResultsController<Relapse>! = NSFetchedResultsController<Relapse>()
    struct RelapseDetails {
        var date: String
    }
    var relapseDetails = RelapseDetails(date: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchControllerInitializing()
        updateTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        resultSearchController.searchBar.isHidden = false;
        copyRelapseDatesToTableDataForSearching()
        updateTable()
    }
    
    func copyRelapseDatesToTableDataForSearching() {
        tableData.removeAll()
        if let vector = CoreDataManager.getArrayOfRelapseDates() {
            tableData = vector
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rlpDetailsVC = segue.destination as! RelapseDetailsVC
        rlpDetailsVC.relapseDetails.date = relapseDetails.date
    }
}


// MARK:- SearchBar
extension RelapsesVC: UISearchResultsUpdating {
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
