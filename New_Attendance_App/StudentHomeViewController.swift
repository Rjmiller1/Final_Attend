//
//  StudentHomeViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/10/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import MapKit

class StudentHomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var attendanceButton: UIButton!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var sections:[Section]? = nil
    
        
    var didAttend = false
    
    override func viewDidLoad() {
        pickerView.isHidden = false
        pickerView.delegate = self
        pickerView.dataSource = self
        sections = mainInstance.currentStudent?.sections?.allObjects as? [Section]
        pickerView.reloadAllComponents()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        try! Auth.auth().signOut()
        //mainInstance.currentStudent?.loggedIn = false
        //mainInstance.currentStudent = nil
        mainInstance.currentStudent?.loggedIn = false
        if(CoreDataHandler.cleanDeleteInstructors()){
            print("Successfully deleted all instructors from Core Data.")
        }
        if(CoreDataHandler.cleanDeleteSections()){
            print("Successfully deleted all sections from Core Data.")
        }
        if(CoreDataHandler.cleanDeleteStudents()){
            print("Successfully deleted all students from Core Data.")
        }
        self.performSegue(withIdentifier: "backToHomeScreen", sender: self)
    }
    
    @IBAction func addClass(_ sender: Any){
        self.performSegue(withIdentifier: "toAddClass", sender: self)
    }
    
    @IBAction func attendancePressed(_ sender: UIButton){
        if pickerView.isHidden{
            pickerView.isHidden = false
        }
        if (attendanceOpen == true){
            didAttend = true
            sendAlert(self, alert: "Success!", message: "Attendance Recorded!");
            //print("MADE IT HERE")
        }
        else{
            sendAlert(self, alert: "Uh Oh!", message: "Attendance period is not open");
        }
    }
    
    @IBAction func checkLocationPressed(_ sender: Any){
        
        //Getting users location
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        locationManager.distanceFilter = 100
        
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(51.509, -0.1337), radius: 10000, identifier: "Test around area")
        
        locationManager.startMonitoring(for: geoFenceRegion)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for currentLocation in locations{
            print("\(index): \(currentLocation)")
            // "0: [locations]"
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered: \(region.identifier)")
        sendAlert(self, alert: "Success!", message: "You are within the attendance radius")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited: \(region.identifier)")
        sendAlert(self, alert: "Uh Oh!", message: "You are not within the attendance radius")
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return sections!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections![row].section_id
    }
 
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    

}
