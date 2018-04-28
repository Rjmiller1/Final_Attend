//
//  InstructorHomeViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/10/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import Firebase
import CoreData

var alert: UIAlertController!

class InstructorHomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    
    var sections:[Section]?
    var pickedSection: Section?
    
    override func viewDidLoad() {
        
        if pickerView.isHidden{
                    pickerView.isHidden = false
        }

        pickerView.delegate = self
        pickerView.dataSource = self
        sections = mainInstance.currentInstructor?.sections?.allObjects as? [Section]

        if(sections != nil){
        for i in sections! {
            print("Sections not nil so one was added, attempting to print section item i.")
            print(i)
            print(i.section_id ?? "none")
        }
        }
        pickerView.reloadAllComponents()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        mainInstance.currentInstructor?.loggedIn = false
        mainInstance.currentInstructor = nil
        self.performSegue(withIdentifier: "backToHomeScreen", sender: self)
    }
    
    @IBAction func enableAttendance(_ sender: Any){
        attendanceOpen = true;
        if(pickedSection != nil){
            pickedSection?.active = true
            print("Given section has successfully been added using pickerview selection.")
        }
        else{
            print("pickerview method is not working.")
        }
        sendAlert(self, message: "Attendance Enabled");
    }
    
    @IBAction func disableAttendance(_ sender: Any){
        attendanceOpen = false;
        if(pickedSection != nil){
            pickedSection?.active = false
            sendAlert(self, message: "Attendance Disabled")
        }
        else{
            sendAlert(self, message: "Unable to disable attendance... Section not selected.")
        }
    }
    
    @IBAction func sendToLocation(_ sender: Any){
        mainInstance.currentSection = pickedSection!
        self.performSegue(withIdentifier: "toLocation", sender: self)
    }

    @IBAction func sendToReport(_ sender: Any){
        self.performSegue(withIdentifier: "toAttendanceReport", sender: self)
    }
    
    @IBAction func sendToAddClass(_ sender: Any){
        self.performSegue(withIdentifier: "toInstructorAddClass", sender: self)
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(sections != nil){
        return self.sections!.count
        }
        else {
            print("Sections is nil")
            return 0}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(sections != nil){
            pickedSection = sections![row]
            mainInstance.currentSection = pickedSection
            return sections![row].section_id
        }
        else {return "None"}
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func sendAlert(_ sender: Any, message: String){
        let alert = UIAlertController(title: "Success!", message: message, preferredStyle: UIAlertControllerStyle.alert)
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

}
