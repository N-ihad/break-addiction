//
//  RelapseVC.swift
//  Break Addiction
//
//  Created by Nihad on 4/17/20.
//  Copyright © 2020 Nihad Samedov. All rights reserved.
//

import UIKit

class RelapseVC: UIViewController {
    @IBOutlet weak var whenItHappenedDP: UIDatePicker!
    @IBOutlet weak var triggerTF: UITextField!
    @IBOutlet weak var placeTF: UITextField!
    @IBOutlet weak var whyItHappenedTF: UITextView!
    var whenItHappened = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        initialConfigurations()
    }
    
    func initialConfigurations() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        whenItHappened = formatter.string(from: whenItHappenedDP.date)
        whenItHappenedDP.addTarget(self, action: #selector(RelapseVC.handler), for: UIControl.Event.valueChanged)
        whyItHappenedTF.text = "    Why do you think it happened"
        whyItHappenedTF.textColor = UIColor.lightGray
    }
    
    @objc func handler(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        whenItHappened = formatter.string(from: sender.date)
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        if whyItHappenedTF.text!.contains("Why do you think it happened") { whyItHappenedTF.text = "" }
        // relapsed(on date: Date, with trigger: String, _ place: String, and ownExplanation: String)
        
        CoreDataManager.relapsed(on: whenItHappenedDP.date, with: triggerTF.text!, placeTF.text!, and: whyItHappenedTF.text!)
        
        dismiss(animated: true, completion: nil)
    }
}

extension RelapseVC: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "    Why do you think it happened"
            textView.textColor = UIColor.lightGray
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
