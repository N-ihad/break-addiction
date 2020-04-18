//
//  FirstViewController.swift
//  Break Addiction
//
//  Created by Nihad on 4/16/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var addictionName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isThereAddiction()
        setUpAddiction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        if let addiction = CoreDataManager.fetchAddictionEntity() {
//            print("AddictionAbstainingStartDate: \(CoreDataManager.convertDateToString(date: addiction.abstainingStartDate))\n")
//            for everyEl in addiction.relapses! {
//                print("Streak: \(everyEl.streak)")
//            }
//        }
    }
    
    func setUpAddiction() {
        if let addiction = CoreDataManager.fetchAddictionEntity() {
            addictionName.text = addiction.name
            
        }
    }
    
    func isThereAddiction() {
        if CoreDataManager.fetchAddictionEntity() == nil {
            presentSettingAddictionVC()
        }
    }
    
    
}

extension UIViewController {
    func presentSettingAddictionVC(){
        let settingAddictionVC: SettingAddictionVC = self.storyboard?.instantiateViewController(withIdentifier: "settingAddictionID") as! SettingAddictionVC
        settingAddictionVC.isModalInPresentation = true
        self.present(settingAddictionVC, animated: false, completion: nil)
    }
}

