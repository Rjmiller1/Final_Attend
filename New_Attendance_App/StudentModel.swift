//
//  StudentModel.swift
//  New_Attendance_App
//
//  Created by Michael Gable on 4/18/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//
import Foundation
class StudentModel {
    var username: String
    var email: String
    var password: String
    var instructors = [InstructorModel]()
    var sections = [SectionModel]()
    var loggedIn = false
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.password = password
        self.email = email
    }
    
    func getUsername() -> String {
        return username
    }
    
    func getPassword() -> String {
        return password
    }
    
    func getInstructors() -> Array<InstructorModel> {
        return instructors
    }
    
    func getSections() -> Array<SectionModel> {
        return sections
    }
    
    func getEmail() -> String {
        return email
    }
    
    func setUsername(user: String) {
        username = user
    }
    
    func setPassword(pass: String) {
        password = pass
    }
    
    func addInstructor(instructor: InstructorModel) {
        instructors.append(instructor)
    }
    
    func addSection(section: SectionModel) {
        sections.append(section)
    }
    
    func login() {
        loggedIn = true
    }
    
    func logout() {
        loggedIn = false
    }
}
