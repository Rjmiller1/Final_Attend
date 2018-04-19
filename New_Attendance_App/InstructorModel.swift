//
//  InstructorModel.swift
//  New_Attendance_App
//
//  Created by Michael Gable on 4/18/18.
//  Copyright © 2018 Robert Miller. All rights reserved.
//

import Foundation
class InstructorModel{
    var username: String
    var email: String
    var sections = [SectionModel]()
    var attStatus: Bool
    var radius: Int
    var loggedIn = false
    var password: String
    
    init(username: String, email: String, password: String, attStatus: Bool, radius: Int){
        self.username = username
        self.attStatus = attStatus
        self.radius = radius
        self.password = password
        self.email = email
    }
    
    func getUsername() -> String {
        return username
    }
    
    func getAttStatus() -> Bool {
        return attStatus
    }
    
    func getRadius() -> Int {
        return radius
    }
    
    func getSectionIDs() -> Array<SectionModel> {
        return sections
    }
    
    func setUsername(user: String) {
        username = user
    }
    
    func setAttStatus(status: Bool) {
        attStatus = status
    }
    
    func addSection(section: SectionModel) {
        sections.append(section)
    }
    
    func removeSection(id: String){
        
    }
    
    func getEmail() -> String {
        return email
    }
    
    func login() {
        loggedIn = true
    }
    
    func logout() {
        loggedIn = false
    }

}
