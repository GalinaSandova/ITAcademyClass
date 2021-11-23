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

extension SectionOfStudent {
    
    static func getStudents() -> [SectionOfStudent] {
        return [SectionOfStudent(students: Student.all)]
    }
    
    static func getStudentsBySex() -> [SectionOfStudent] {
        return [
            SectionOfStudent("List of boys students",
                             students: Student.all.filter({ $0.sex == .boy})),
            SectionOfStudent("List of girls students",
                             students: Student.all.filter({ girl in return girl.sex == .girl}))]
    }
    
    static func getStudentsByAge() -> [SectionOfStudent] {
        let sortStrudents = Student.all.sorted(by: { $0.yearOfBirth < $1.yearOfBirth})
        var yearOfBirth: Int? = nil
        var yearOfBirthStrudent:[Student] = []
        
        var sections: [SectionOfStudent]  = []
        
        for student in sortStrudents {
            if yearOfBirth == nil {
                yearOfBirth = student.yearOfBirth
                yearOfBirthStrudent = [student]
            } else if yearOfBirth == student.yearOfBirth {
                yearOfBirthStrudent.append(student)
            } else if let yearlet = yearOfBirth, yearOfBirth != student.yearOfBirth {
                sections.append(SectionOfStudent("\(yearlet)", students: yearOfBirthStrudent))
                yearOfBirth = student.yearOfBirth
                yearOfBirthStrudent = [student]
            }
        }
        
        if let yearlet = yearOfBirth {
            sections.append(SectionOfStudent("\(yearlet)", students: yearOfBirthStrudent))
        }
        return sections
    }
    
    static func getStudentsByFirstLetter() -> [SectionOfStudent] {
        let sortStrudents = Student.all.sorted(by: { $0.name < $1.name})
        var firstLetter: String? = nil
        var firstLeterStudent:[Student] = []
        
        var sections: [SectionOfStudent]  = []
        
        for student in sortStrudents {
            let first = "\(student.name.first ?? " ")"
            if firstLetter == nil {
                firstLetter = first
                firstLeterStudent = [student]
            } else if firstLetter == first {
                firstLeterStudent.append(student)
            } else if let firstLetterlet = firstLetter, firstLetter != first{
                sections.append(SectionOfStudent("\(firstLetterlet)", students: firstLeterStudent))
                firstLetter = first
                firstLeterStudent = [student]
            }
        }
        
        if let firstLetterlet = firstLetter {
            sections.append(SectionOfStudent("\(firstLetterlet)", students: firstLeterStudent))
        }
        return sections
    }
}
