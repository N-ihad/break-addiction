//
//  RelapseDetailsVC.swift
//  Break Addiction
//
//  Created by Nihad on 4/17/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class RelapseDetailsVC: UIViewController {
    @IBOutlet weak var relapseDateL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        relapseDateL.text = CoreDataManager.convertDateToString(date: fetchedResultsController.object(at: indPath).whenItHappened)
    }
}
