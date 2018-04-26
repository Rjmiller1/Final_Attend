//
//  SignUpViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/10/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import Firebase

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
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                //Auth.auth().currentUser.
                
                if email.range(of:"mail") != nil {
                    if(CoreDataHandler.addInstructor(username: username, email: email, password: pass, loggedIn: false)){
                        print("Successfully created instructor using Core Data!")
                    }
                    
                }
                else {
                    if(CoreDataHandler.addStudent(username: username, password: pass, email: email, loggedIn: false)){
                        print("Successfully created student using Core Data!")
                    }
                }
                
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        print("Error: \(error!.localizedDescription)")
                        //self.sendAlert(self, message: "Invalid Account Credentials")
                    }
                }
                
                
                //self.performSegue(withIdentifier: "toHomeScreen", sender:self)
                
            }
            
            else {
                print("Error: \(error!.localizedDescription)")
                self.sendAlert(self, message: "Invalid Account Credentials")
            }
            
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
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
