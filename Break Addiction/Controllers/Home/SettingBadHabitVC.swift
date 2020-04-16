//
//  SettingBadHabitVC.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class SettingBadHabitVC: UIViewController {
    @IBOutlet weak var addictionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func readyButton(_ sender: UIButton) {
        CoreDataManager.setAddiction(with: addictionTF.text!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addictionTF.resignFirstResponder()
    }
}



extension SettingBadHabitVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
