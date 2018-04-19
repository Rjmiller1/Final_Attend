//
//  InstructorHomeViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/10/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import Firebase

var alert: UIAlertController!

class InstructorHomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        
        if pickerView.isHidden{
                    pickerView.isHidden = false
        }

        pickerView.delegate = self
        pickerView.dataSource = self
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
        return (mainInstance.currentInstructor?.sections.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainInstance.currentInstructor?.sections[row].section_id
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
