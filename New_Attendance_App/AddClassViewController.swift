//
//  AddClassViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/16/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class AddClassViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var section_id: String?
    @IBOutlet weak var pickerView: UIPickerView!

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToStudentHome", sender: self)
    }
    
    @IBAction func addClass(_ sender: Any){
        let student = mainInstance.currentStudent
        for i in mainInstance.sections {
            if(i.section_id == section_id){
                student?.addSection(section: i)
                print("Successfully added section: ",section_id as Any)

            }
        }
        self.performSegue(withIdentifier: "toStudentHomeView", sender: self)


    }
    
    func sendAlert(_ sender: Any, alert: String, message: String){
        let alert = UIAlertController(title: alert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return mainInstance.sections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainInstance.sections[row].section_id
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        section_id = mainInstance.sections[row].section_id
    }

}
