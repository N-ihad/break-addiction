//
//  TriggerDetailsVC.swift
//  Break Addiction
//
//  Created by Nihad on 4/17/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class TriggerDetailsVC: UIViewController {
    @IBOutlet weak var triggerNameL: UILabel!
    var triggerDetails = TriggerDetails(name: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        triggerNameL.text = triggerDetails.name
    }
}
