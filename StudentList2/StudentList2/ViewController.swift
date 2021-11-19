//
//  ViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/18/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [SectionOfStudent] = SectionOfStudent.getStudents() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Students"
        tableView.dataSource = self
    }

    
    @IBAction func groupAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Group", message: "Please Choose", preferredStyle: .actionSheet)
        
    
        alert.addAction(UIAlertAction(title: "Sex",
                                      style: .default,
                                      handler: { _ in
            self.dataSource = SectionOfStudent.getStudentsBySex()
        }))
        
        alert.addAction(UIAlertAction(title: "First letter",
                                      style: .default,
                                      handler: { _ in
            self.dataSource = SectionOfStudent.getStudentsByFirstLetter()
        }))
        
        alert.addAction(UIAlertAction(title: "By Year Of Birth",
                                      style: .default,
                                      handler: { _ in
            self.dataSource = SectionOfStudent.getStudentsByAge()
        }))
        
        alert.addAction(UIAlertAction(title: "Ungrouping",
                                      style: .destructive,
                                      handler: { _ in
            self.dataSource = SectionOfStudent.getStudents()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionOfStudent: SectionOfStudent = dataSource[section]
//        let count = sectionOfStudent.students.count
//        return count
        return dataSource[section].students.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].nameOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("section = \(indexPath.section), row = \(indexPath.row)")
        let sectionOfStudent: SectionOfStudent = dataSource[indexPath.section]
        let student = sectionOfStudent.students[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentTableViewCell
        cell.nameLabel.text = student.name
        
        return cell
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
        
        for strudent in sortStrudents {
            if yearOfBirth == nil {
                yearOfBirth = strudent.yearOfBirth
                yearOfBirthStrudent = [strudent]
            } else if yearOfBirth == strudent.yearOfBirth {
                yearOfBirthStrudent.append(strudent)
            } else if let yearlet = yearOfBirth, yearOfBirth != strudent.yearOfBirth {
                sections.append(SectionOfStudent("\(yearlet)", students: yearOfBirthStrudent))
                yearOfBirth = strudent.yearOfBirth
                yearOfBirthStrudent = [strudent]
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
        var yearOfBirthStrudent:[Student] = []
        
        var sections: [SectionOfStudent]  = []
        
        for strudent in sortStrudents {
            let first = "\(strudent.name.first ?? " ")"
            if firstLetter == nil {
                firstLetter = first
                yearOfBirthStrudent = [strudent]
            } else if firstLetter == first {
                yearOfBirthStrudent.append(strudent)
            } else if let firstLetterlet = firstLetter, firstLetter != first{
                sections.append(SectionOfStudent("\(firstLetterlet)", students: yearOfBirthStrudent))
                firstLetter = first
                yearOfBirthStrudent = [strudent]
            }
        }
        
        if let firstLetterlet = firstLetter {
            sections.append(SectionOfStudent("\(firstLetterlet)", students: yearOfBirthStrudent))
        }
        return sections
    }
}



