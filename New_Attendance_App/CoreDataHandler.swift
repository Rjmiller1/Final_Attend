//
//  CoreDataHandler.swift
//  New_Attendance_App
//
//  Created by Michael Gable on 4/25/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
    class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func addStudent(username:String, password:String, email: String, loggedIn: Bool) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(username, forKey: "username")
        managedObject.setValue(password, forKey: "password")
        managedObject.setValue(email, forKey: "email")
        managedObject.setValue(loggedIn, forKey: "loggedIn")
        
        do{
            try context.save()
            print("Student successfully added in Core Data addStudent()")
            return true
        }catch{
            print("Could not create student.")
            return false
        }
    }
    
    class func addInstructor(username: String, email: String, password: String, loggedIn: Bool) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Instructor", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(username, forKey: "username")
        managedObject.setValue(email, forKey: "email")
        managedObject.setValue(password, forKey: "password")
        managedObject.setValue(loggedIn, forKey: "loggedIn")
        
        do{
            try context.save()
            print("Instructor successfully added in Core Data addInstructor()")
            return true
        }catch{
            print("Could not create instructor.")
            return false
        }
    }
    
    class func addSection(total: Int, section_id: String, active: Bool, radius: Int) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Section", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObject.setValue(total, forKey: "total")
        managedObject.setValue(section_id, forKey: "section_id")
        managedObject.setValue(active, forKey: "active")
        managedObject.setValue(radius, forKey: "radius")
        
        do{
            try context.save()
            print("Section successfully added using Core Data in addSection()")
            return true
        }catch{
            print("Could not create section.")
            return false
        }
    }
    
    class func fetchStudents() -> [Student]? {
        let context = getContext()
        var student:[Student]? = nil
        do{
            student = try context.fetch(Student.fetchRequest())
            return student
        }catch{
            print("No students found.")
            return student
        }
    }
    
    class func fetchSections() -> [Section]? {
        let context = getContext()
        var sections:[Section]? = nil
        
        do{
            sections = try context.fetch(Section.fetchRequest())
            return sections
        }catch{
            print("No sections found.")
            return sections
        }
    }
    
    class func getSections() -> [Section]? {
        let context = getContext()
        var section:[Section]? = nil
        do{
            section = try context.fetch(Section.fetchRequest())
            return section
        }catch{
            print("No sections found.")
            return section
        }
    }
    
    class func removeStudent(student: Student) -> Bool{
        let context = getContext()
        context.delete(student)
        
        do{
            try context.save()
            return true
        }catch{
            print("Error: unable to delete student")
            return false
        }
    }
    
    class func cleanDeleteStudents() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Student.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch{
            print("unable to clean delete students")
            return false
        }
    }
    
    class func cleanDeleteInstructors() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Instructor.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            print("unable to delete instructors.")
            return false
        }
    }
    
    class func cleanDeleteSections() -> Bool{
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Section.fetchRequest())
        
        do{
            try context.execute(delete)
            return true
        }catch{
            print("unable to delete sections.")
            return false
        }
    }
    
    class func findStudentsInSection(section_id: String) -> [Student]?{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        var students:[Student]? = nil
        let predicate = NSPredicate(format: "username contains[c] %@", section_id)
        fetchRequest.predicate = predicate
        
        do{
            students = try context.fetch(fetchRequest)
            return students
        }catch{
            print("Error: no students were found containing the given section ID.")
            return students
        }
    }
    
    class func getSectionIDs() -> [String]?{
        let context = getContext()
        var section:[Section]? = nil
        var sections:[String]? = nil
        do{
            section = try context.fetch(Section.fetchRequest())
        }catch{
            print("No sections in database.")
        }
        for i in section!{
            sections?.append(i.section_id!)
        }
        return sections
    }
    
    class func getCurrentStudent() -> Student{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        let currentStudent:Student? = nil
        var students:[Student]? = nil
        let predicate = NSPredicate(format: "loggedIn == true")
        fetchRequest.predicate = predicate
        
        
        do{
            students = try context.fetch(fetchRequest)
            for i in students!{
                if i.loggedIn == true{
                    print("Student found in Core Data database!")
                    return i
                }
            }
        }catch{
            print("Unable to find student.")
            return currentStudent!
        }
        print("Never entered do condition in getCurrentStudent().")
        return currentStudent!
    }
    
    class func getCurrentInstructor() -> Instructor{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Instructor> = Instructor.fetchRequest()
        let currentInstructor:Instructor? = nil
        var instructors:[Instructor]? = nil
        let predicate = NSPredicate(format: "loggedIn == true")
        fetchRequest.predicate = predicate
        
        
        do{
            instructors = try context.fetch(fetchRequest)
            for i in instructors!{
                if i.loggedIn == true{
                    print("Instructor found in Core Data database!")
                    return i
                }
            }
        }catch{
            print("Unable to find instructor.")
            return currentInstructor!
        }
        print("Never entered do condition in getCurrentStudent().")
        return currentInstructor!
    }
    
    
    
    class func getSectionBySectionID(section_id: String) -> Section{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Section> = Section.fetchRequest()
        let placeholder:Section? = nil
        var sections: [Section]? = nil
        let predicate = NSPredicate(format: "section_id == %@",section_id)
        fetchRequest.predicate = predicate
        
        do{
            sections = try context.fetch(fetchRequest)
            for i in sections!{
                if i.section_id == section_id {
                    print("Section found by section ID.")
                    return i
                }
            }
        }catch{
            print("Error, could not find section by Section ID.")
            return placeholder!
        }
        return placeholder!
    }
    
    class func getInstructorByEmail(email: String) -> Instructor?{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Instructor> = Instructor.fetchRequest()
        let placeholder:Instructor? = nil
        var instructors: [Instructor]? = nil
        let predicate = NSPredicate(format: "email == %@",email)
        fetchRequest.predicate = predicate
        
        do{
            instructors = try context.fetch(fetchRequest)
            if instructors?.count == 1{
                print("Instructor found by email in Core Data!")
                return instructors!.first
            }
            else{
                print("More or less than one matching instructor email.")
                return placeholder!
            }
        }catch{
            print("Error, reached catch section.")
        }
        return placeholder
    }
    
    class func getStudentByEmail(email: String) -> Student?{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        let placeholder:Student? = nil
        var students: [Student]? = nil
        let predicate = NSPredicate(format: "email == %@",email)
        fetchRequest.predicate = predicate
        
        do{
            students = try context.fetch(fetchRequest)
            if students?.count == 1{
                print("Student found by email in Core Data!")
                return students!.first
            }
            else{
                print("More or less than one matching instructor email.")
                return placeholder!
            }
        }catch{
            print("Error, reached catch section.")
        }
        return placeholder
    }
    
    class func verifyStudentExists(email: String) -> Bool{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        var students: [Student]? = nil
        let predicate = NSPredicate(format: "email == %@",email)
        fetchRequest.predicate = predicate
        
        do{
            students = try context.fetch(fetchRequest)
            if students?.count == 1{
                print("Student found by email in Core Data!")
                return true
            }
            else{
                print("More or less than one matching instructor email.")
                return false
            }
        }catch{
            print("Error, reached catch section.")
        }
        return false
    }
    
    class func verifyStudentAccount(email: String, password: String) -> Bool{
        if(verifyStudentExists(email: email)){
            let student = getStudentByEmail(email: email)
            if((student?.email == email) && (student?.password == password)){
                print("Student authenticated successfully in CoreDataHandler.verifyStudentAccount!")
                return true
            }
            else{return false}
        }
        return false;
    }
    
    class func verifyInstructorExists(email: String) -> Bool{
        let context = getContext()
        let fetchRequest: NSFetchRequest<Instructor> = Instructor.fetchRequest()
        var instructors: [Instructor]? = nil
        let predicate = NSPredicate(format: "email == %@",email)
        fetchRequest.predicate = predicate
        
        do{
            instructors = try context.fetch(fetchRequest)
            if instructors?.count == 1{
                print("Instructor found by email in Core Data!")
                return true
            }
            else{
                print("More or less than one matching instructor email.")
                return false
            }
        }catch{
            print("Error, reached catch section.")
        }
        return false
    }
    
    class func verifyInstructorAccount(email: String, password: String) -> Bool{
        if(verifyInstructorExists(email: email)){
            let instructor = getInstructorByEmail(email: email)
            if((instructor?.email == email) && (instructor?.password == password)){
                print("Instructor authenticated successfully in CoreDataHandler.verifyInstructorAccount!")
                return true
            }
            else{return false}
        }
        return false;
    }
    
    
}


