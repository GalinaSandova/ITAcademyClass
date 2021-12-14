//
//  WADefaulst.swift
//  StudentList2
//
//  Created by Halina Sandova on 12/12/21.
//

import Foundation
class WADefaults {
    static let sh = WADefaults()
    
    private struct Keys {
        static let students = "WAStudents"
    }
    
    var students: [Student] {
        get {
            self.loadStudents()
        }
        set(newStudent) {
            self.saveStudents(newStudent)
        }
    }

    private func saveStudents(_ students: [Student]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(students) {
        UserDefaults.standard.setValue(data, forKey: Keys.students)
        }
    }
    
    private func loadStudents() -> [Student] {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: Keys.students),
        let students = try? decoder.decode([Student].self, from: data) {
            return students
        } else {
            return []
        }
    }
}
