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
    var section_ids:[String]?
    
    override func viewDidLoad() {
        
        if pickerView.isHidden{
                    pickerView.isHidden = false
        }

        pickerView.delegate = self
        pickerView.dataSource = self
        sections = mainInstance.currentInstructor?.sections?.allObjects as? [Section]

        if(sections != nil){
        for i in sections! {
            print(i.section_id ?? "none")
            section_ids?.append(i.section_id!)
        }
            print("Current sections to be sent to pickerView:")
            if(section_ids != nil){
            for i in section_ids!{
                print(i)
            }
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
        print("Hi")
        if(CoreDataHandler.cleanDeleteInstructors()){
            print("Successfully deleted all instructors from Core Data.")
            NSLog("Successfully deleted all instructors from Core Data. NSLog.")
        }
        else{
            print("Could not remove instructors.")
            NSLog("Could not remove instructors. NSLog.")
        }
        if(CoreDataHandler.cleanDeleteSections()){
            print("Successfully deleted all sections from Core Data.")
        }
        else{
          print("Could not delete all sections.")
        }
        if(CoreDataHandler.cleanDeleteStudents()){
            print("Successfully deleted all students from Core Data.")
        }
        else{ print("could not delete all students.")}
        try! Auth.auth().signOut()
        mainInstance.currentInstructor?.loggedIn = false
        mainInstance.currentInstructor = nil
        self.performSegue(withIdentifier: "backToHomeScreen", sender: self)
    }
    
    @IBAction func enableAttendance(_ sender: Any){
        attendanceOpen = true;
        sendAlert(self, message: "Attendance Enabled");
    }
    
    @IBAction func disableAttendance(_ sender: Any){
        attendanceOpen = false;
        sendAlert(self, message: "Attendance Disabled");
    }
    
    @IBAction func sendToLocation(_ sender: Any){
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
        else {return 0}
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(sections != nil){
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
