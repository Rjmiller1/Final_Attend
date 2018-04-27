//
//  SignUpViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/10/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButton(_ sender:Any){
        guard let username = usernameField.text else { return }
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
                if email.range(of:"mail") != nil {
                    if(!CoreDataHandler.verifyInstructorExists(email: email)){
                    if(CoreDataHandler.addInstructor(username: username, email: email, password: pass, loggedIn: false)){
                        print("Successfully created instructor using Core Data!")
                    }
                    }else{self.sendAlert(self, message: "Instructor account already exists")}
                }
                else {
                    if(!CoreDataHandler.verifyStudentAccount(email: email, password: pass)){
                    if(CoreDataHandler.addStudent(username: username, password: pass, email: email, loggedIn: false)){
                        print("Successfully created student using Core Data!")
                    }
                    }
                    else{self.sendAlert(self, message: "Student account already exists")}
                }
    }
    
    @IBAction func backButton(_ sender:Any){
        self.performSegue(withIdentifier: "backToHome", sender:self)
    }
    
    func sendAlert(_ sender: Any, message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertControllerStyle.alert)
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
