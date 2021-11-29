//
//  Student.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/19/21.
//

import Foundation


class Student {
    
    enum Sex {
        case girl
        case boy
    }
    
    let name: String
    let sex: Sex
    let avatar: String?
    let yearOfBirth: Int
    
    init(_ name: String, sex: Sex, yearOfBirth: Int, avatar: String? ) {
        self.name = name
        self.sex = sex
        self.yearOfBirth = yearOfBirth
        self.avatar = avatar
    }
}

//extension Student: Equatable {
//    static func == (lhs: Student, rhs: Student) -> Bool {
//        return lhs.name == rhs.name
//        && lhs.yearOfBirth == rhs.yearOfBirth
//        && lhs.avatar == rhs.avatar
//        && lhs.sex == rhs.sex
//    }
//}

extension Student {
    static let all: [Student] = [
        Student("Aртимович Игорь Владимирович", sex: .boy, yearOfBirth: 1980, avatar: "student_b"),
        Student("Богданович Дмитрий Александрович", sex: .boy, yearOfBirth: 1972, avatar: "student_b-1"),
        Student("Букаренко Арина Олеговна", sex: .girl, yearOfBirth: 1987, avatar: "student_g-4"),
        Student("Гришин Павел Андреевич", sex: .boy, yearOfBirth: 2004, avatar: "student_b-2"),
        Student("Ефименко Анастасия Владимировна", sex: .girl, yearOfBirth: 2012, avatar: "student_g-1"),
        Student("Куклицкий Максим Сергеевич", sex: .boy, yearOfBirth: 2021, avatar: "student_b-8"),
        Student("Лапин Николай Владимирович", sex: .boy, yearOfBirth: 2000, avatar: "student_b-4"),
        Student("Малишевский Никита Валерьевич", sex: .boy, yearOfBirth: 1745, avatar: "error"),
        Student("Матвеенко Сергей Александрови", sex: .boy, yearOfBirth: 2012, avatar: "student_b-5"),
        Student("Мостовой Алексей Алексеевич", sex: .boy, yearOfBirth: 1999, avatar: "student_b-6"),
        Student("Пачковский Михаил Тадеушевич", sex: .boy, yearOfBirth: 1998, avatar: "student_b-7"),
        Student("Пернацкая Алеся Юрьевна", sex: .girl, yearOfBirth: 1997, avatar: "student_g-2"),
        Student("Савков Александр Геннадьевич", sex: .boy, yearOfBirth: 2003, avatar: nil),
        Student("Сандова Галина Александровна", sex: .girl, yearOfBirth: 1956, avatar: "student_g-3"),
        Student("Симонов Владислав Дмитриевич", sex: .boy, yearOfBirth: 1996, avatar: "student_b-3"),
        Student("Сысов Валерий Александрович", sex: .boy, yearOfBirth: 1999, avatar: nil),
        Student("Елисеева Марина Михайловна", sex: .girl, yearOfBirth: 1999, avatar: "student_g"),
        Student("Сандова Галина Александровна", sex: .girl, yearOfBirth: 1996, avatar: "student_gff"),
    ].sorted(by: {$0.name < $1.name})
}
