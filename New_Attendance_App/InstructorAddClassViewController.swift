//
//  InstructorAddClassViewController.swift
//  New_Attendance_App
//
//  Created by Nicholas Furbee on 4/18/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit

class InstructorAddClassViewController: UIViewController {
    
    @IBOutlet weak var addClassField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToInstructor(_ sender: Any){
        self.performSegue(withIdentifier: "BackToInstructor2", sender: self)
    }
    
    @IBAction func submitClass(_ sender: Any) {
        guard let section_id = addClassField?.text else { return }
        let section = SectionModel(instructor: ((mainInstance.currentInstructor?.getUsername())!), total: 0, section_id: section_id, active: false)
        mainInstance.currentInstructor?.addSection(section: section)
        mainInstance.sections.append(section)
        self.performSegue(withIdentifier: "backToInstructorHome", sender: self)
        
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
