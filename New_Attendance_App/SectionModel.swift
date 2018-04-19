//
//  SectionModel.swift
//  New_Attendance_App
//
//  Created by Michael Gable on 4/18/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//
import Foundation

class SectionModel{
    var instructor: String
    var students = [String]()
    var total: Int
    var section_id: String
    var active: Bool
    
    init(instructor: String, total: Int, section_id: String, active: Bool){
        self.instructor = instructor
        self.total = total
        self.section_id = section_id
        self.active = active
        
    }
    
    func getInstructor() -> String{
        return instructor
    }
    
    func getStudents() -> Array<String>{
        return students
    }
    
    func getTotal() -> Int{
        return total
    }
    
    func getSectionID() -> String{
        return section_id
    }
    
    func getActive() -> Bool{
        return active
    }
    
    func setInstructor(user: String){
        instructor = user
    }
    
    func addStudent(username: String){
        students.append(username)
    }
    
    func setSectionID(id: String){
        section_id = id
    }
    
    func removeStudent(username: String){
        
    }
    
    func setInstructor(ins: String){
        instructor = ins
    }
    
}
