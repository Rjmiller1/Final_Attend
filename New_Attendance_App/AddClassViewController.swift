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


class AddClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToStudentHome", sender: self)
    }
    

    
    @IBOutlet var myTableView: UITableView!{
        didSet{
            myTableView.dataSource = self
        }
    }
 
    var classes = [String]()
    var newClass: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classes = ["EE 221", "EE 327"]
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as UITableViewCell
        
        cell.textLabel?.text = classes[indexPath.row]
        
        return cell
    }

}
