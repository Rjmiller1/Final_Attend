//
//  LoginViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/9/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

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
    
    @IBAction func backButton(_ sender:Any){
        self.performSegue(withIdentifier: "backToHome", sender:self)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
                    if email.range(of:"mail") != nil {
                    if(CoreDataHandler.verifyInstructorAccount(email: email, password: pass)){
                    mainInstance.currentInstructor = CoreDataHandler.getInstructorByEmail(email: email)
                    mainInstance.currentInstructor?.loggedIn = true
                    print("Instructor logged in with following username/email")
                    print(mainInstance.currentInstructor?.username ?? "Not found")
                    
                    self.performSegue(withIdentifier: "toInstructorHomeScreen", sender:self)
                    }
                    else{
                        self.sendAlert(self, message: "Error. incorrect username of password.")
                }
                    }
                else {
                        if(CoreDataHandler.verifyStudentAccount(email: email, password: pass)){
                        mainInstance.currentStudent = CoreDataHandler.getStudentByEmail(email: email)
                        mainInstance.currentStudent?.loggedIn = true
                        print("Student logged in with following username")
                        print(mainInstance.currentStudent?.username ?? "Not found")
                        
                        self.performSegue(withIdentifier: "toStudentHomeScreen", sender:self)
                    }
                    else{
                        self.sendAlert(self, message: "Error. incorrect username of password.")
                        }
                    }
    }
    
    func sendAlert(_ sender: Any, message: String){
        let alert = UIAlertController(title: "Try Again!", message: message, preferredStyle: UIAlertControllerStyle.alert)
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
    @IBAction func goToStudentHome(_ sender:Any){
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
                
            } else {
                print("Error logging in: \(error!.localizedDescription)")
     
            }
           self.performSegue(withIdentifier: "toStudentHomeScreen", sender:self)
        }
        
    }
    
    @IBAction func goToTeacherHome(_ sender:Any){
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
                self.performSegue(withIdentifier: "toInstructorHomeScreen", sender:self)
            }
            else {
                print("Error logging in: \(error!.localizedDescription)")
                self.errorMessage.isHidden = false
            }
         
        }
    }
    
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
