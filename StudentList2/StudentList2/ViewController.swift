//
//  ViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/18/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topTableConstaint: NSLayoutConstraint!
    
    var isSerchBarShow: Bool = false {
        didSet {
            searchBar.isHidden = !isSerchBarShow
            topTableConstaint.constant = isSerchBarShow ? 44 : 0
            if isSerchBarShow {
                // show keyboard
                searchBar.searchTextField.becomeFirstResponder()
            } else {
                // remove keyboard
                self.view.endEditing(true)
                //clean textfield
                searchBar.searchTextField.text = ""
                // return last gruping
                setGrouping(wayOfGrouping)
            }
        }
    }
    
    enum Grouping {
        case sex
        case firstLetter
        case byYearOfBirth
        case ungrouping
    }
    
    var wayOfGrouping: Grouping = .ungrouping {
        didSet {
           setGrouping(wayOfGrouping)
        }
    }
    
    var dataSource: [SectionOfStudent] = SectionOfStudent.getStudents() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Students"
        tableView.dataSource = self
        
        isSerchBarShow = false
        searchBar.delegate = self
        
    }
    
    
    @IBAction func groupAction(_ sender: Any) {
        let alert = UIAlertController(title: "Group", message: "Please Choose", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Sex", style: .default, handler: { _ in
            self.wayOfGrouping = .sex
        }))
        
        alert.addAction(UIAlertAction(title: "First letter", style: .default, handler: { _ in
            self.wayOfGrouping = .firstLetter
        }))
        
        alert.addAction(UIAlertAction(title: "By Year Of Birth", style: .default, handler: { _ in
            self.wayOfGrouping = .byYearOfBirth
        }))
        
        alert.addAction(UIAlertAction(title: "Ungrouping", style: .destructive, handler: { _ in
            self.wayOfGrouping = .ungrouping
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func actionSearch(_ sender: Any) {
       isSerchBarShow = !isSerchBarShow
    }
    
    func setGrouping(_ wayOfGrouping: Grouping) {
        switch wayOfGrouping {
        case .sex:
            self.dataSource = SectionOfStudent.getStudentsBySex()
        case .firstLetter:
            self.dataSource = SectionOfStudent.getStudentsByFirstLetter()
        case .byYearOfBirth:
            self.dataSource = SectionOfStudent.getStudentsByAge()
        case .ungrouping:
            self.dataSource = SectionOfStudent.getStudents()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].students.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let nameOfSection = dataSource[section].nameOfSection else { return nil }
        return "\(nameOfSection) - \(dataSource[section].students.count) person(s)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("section = \(indexPath.section), row = \(indexPath.row)")
        let sectionOfStudent: SectionOfStudent = dataSource[indexPath.section]
        let student = sectionOfStudent.students[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentTableViewCell
        cell.nameLabel.text = student.name
        cell.studentImageView.image = UIImage(named: student.avatar ?? "user") ?? UIImage(named: "user")
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        let students = Student.all.filter { student in
            return student.name.lowercased().contains(searchText.lowercased())
        }
        print("students = \(students)")
        dataSource = [SectionOfStudent("Filter", students: students)]
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
