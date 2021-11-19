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

extension Student {
    static let all: [Student] = [
        Student("Aртимович Игорь Владимирович", sex: .boy, yearOfBirth: 1980, avatar: nil),
        Student("Богданович Дмитрий Александрович", sex: .boy, yearOfBirth: 1972, avatar: nil),
        Student("Букаренко Арина Олеговна", sex: .girl, yearOfBirth: 1987, avatar: nil),
        Student("Гришин Павел Андреевич", sex: .boy, yearOfBirth: 2004, avatar: nil),
        Student("Ефименко Анастасия Владимировна", sex: .girl, yearOfBirth: 2012, avatar: nil),
        Student("Куклицкий Максим Сергеевич", sex: .boy, yearOfBirth: 2021, avatar: nil),
        Student("Лапин Николай Владимирович", sex: .boy, yearOfBirth: 2000, avatar: nil),
        Student("Малишевский Никита Валерьевич", sex: .boy, yearOfBirth: 1745, avatar: nil),
        Student("Матвеенко Сергей Александрови", sex: .boy, yearOfBirth: 2012, avatar: nil),
        Student("Мостовой Алексей Алексеевич", sex: .boy, yearOfBirth: 1999, avatar: nil),
        Student("Пачковский Михаил Тадеушевич", sex: .boy, yearOfBirth: 1998, avatar: nil),
        Student("Пернацкая Алеся Юрьевна", sex: .girl, yearOfBirth: 1997, avatar: nil),
        Student("Савков Александр Геннадьевич", sex: .boy, yearOfBirth: 2003, avatar: nil),
        Student("Сандова Галина Александровна", sex: .girl, yearOfBirth: 1956, avatar: nil),
        Student("Симонов Владислав Дмитриевич", sex: .boy, yearOfBirth: 1996, avatar: nil),
        Student("Сысов Валерий Александрович", sex: .boy, yearOfBirth: 1999, avatar: nil),
        Student("Елисеева Марина Михайловна", sex: .girl, yearOfBirth: 1999, avatar: nil),
    ]
}
