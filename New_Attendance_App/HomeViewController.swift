//
//  HomeViewController.swift
//  New_Attendance_App
//
//  Created by Robert Miller on 4/9/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import Foundation
import UIKit
import Firebase



class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
    }

    @IBAction func goToLoginScreen(_ sender:Any){
        self.performSegue(withIdentifier: "toLoginScreen", sender:self)
    }
    
    @IBAction func goToSignUpScreen(_ sender:Any){
        self.performSegue(withIdentifier: "toSignUpScreen", sender: self)
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
