//
//  SecondViewController.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class RelapsesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var people = ["John", "Flex", "St. Pierre"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension RelapsesVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row]
        cell.detailTextLabel?.text = "somedetail + \(indexPath)"
        return cell
    }
}

