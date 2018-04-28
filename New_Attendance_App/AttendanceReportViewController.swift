//
//  AttendanceReportViewController.swift
//  New_Attendance_App
//
//  Created by Michael Gable on 4/26/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import MessageUI

class AttendanceReportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate  {
   
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToDick", sender: self)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        if(sendEmail() == true){
            sendAlert(self, message: "Successfully sent email to " + email!)
        }
        else {sendAlert(self, message: "Error. unable to send email to" + email!)}
    }
    
    @IBOutlet var myTableView: UITableView!
    let roster = mainInstance.currentSection?.students?.allObjects as? [Student]
    let attended = mainInstance.currentSection?.attendedStudents?.allObjects as? [Student]
    let status = ["absent","present"]
    let email = mainInstance.currentInstructor?.email
    var contents:String?
    var i = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.reloadData()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)

        // Do any additional setup after loading the view.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ myTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(roster != nil){
        return roster!.count
        }
        else {
            print("roster is nil")
            return 0}
    }
    
    func didAttend(student: Student) -> Bool{
        for i in attended! {
            if i.username == student.username{
                return true
            }
        }
        return false
    }
    
    func tableView(_ myTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = myTableView.dequeueReusableCell(withIdentifier: "myCell")
        if(roster != nil){
        myCell?.textLabel?.text = roster?[indexPath.row].username
            /*
            var check:Bool
            for i in roster!{
                check = false
                for j in attended! {
                    if (i.username == j.username){
                        check = true
                    }
                    if(check == true){
                        myCell?.detailTextLabel?.text = "\(status[1])"
                    }
                    else{
                        myCell?.detailTextLabel?.text = "\(status[0])"
                        check = false
                    }
                }
            }
            */
        //myCell?.detailTextLabel?.text = "\(share[indexPath.row])"
            if(didAttend(student: (roster![indexPath.row]))){
                myCell?.detailTextLabel?.text = "\(status[1])"
            }
            else{
                myCell?.detailTextLabel?.text = "\(status[0])"
            }
            return myCell!
        }
        print("null tableView (not accessing arrays)")
        return myCell!
    }
    
    func sendEmail() -> Bool {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
           // mail.setToRecipients([email!])
            mail.setToRecipients(["mbgable@mix.wvu.edu"])
            contents = generateContents()
            mail.setMessageBody(contents!, isHTML: false)
            present(mail, animated: true)
            return true
        } else {
            sendAlert(self, message: "unable to generate email in sendEmail()")
            // show failure alert
        }
        return false
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func generateContents() -> String{
        var result = ""
        var check: Bool
        
        for i in roster!{
            check = false
            for j in attended!{
                if (i.username == j.username){
                    check = true
                }
                if(check){
                    result += i.username! + ": present\n"
                }else{
                    result += i.username!  + ": absent\n"
                }
            }
        }
        return result;
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
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
