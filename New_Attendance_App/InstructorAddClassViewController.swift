//
//  InstructorAddClassViewController.swift
//  New_Attendance_App
//
//  Created by Nicholas Furbee on 4/18/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import UIKit
import CoreData


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
      /*
        let section = SectionModel(instructor: ((mainInstance.currentInstructor?.getUsername())!), total: 0, section_id: section_id, active: false)
        mainInstance.currentInstructor?.addSection(section: section)
        mainInstance.sections.append(section) */
        
        if(CoreDataHandler.addSection(total: 0, section_id: section_id, active: false, radius: 100)){
            print("Successfully created section!")
        }
        let section = CoreDataHandler.getSectionBySectionID(section_id: section_id)
        section.instructor = mainInstance.currentInstructor
        mainInstance.currentInstructor?.addToSections(section)
        let context = CoreDataHandler.getContext()
        print("added sections, now trying to save context.")
        do{
            print("Successfully saved Section with Section id...")
            print(section.section_id as Any)
            try context.save()
        }catch{
            print("Unable to save added section.")
        }
        
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
