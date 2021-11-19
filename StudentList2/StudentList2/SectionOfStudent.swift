//
//  SectionOfStudent.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/19/21.
//

import Foundation

class SectionOfStudent {
    let nameOfSection:String?
    let students: [Student]
    
    init (_ name:String? = nil, students:[Student]) {
        nameOfSection = name
        self.students = students
    }
}
