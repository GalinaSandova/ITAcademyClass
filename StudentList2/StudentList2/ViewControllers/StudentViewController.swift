//
//  StudentViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/21/21.
//

import UIKit

class StudentViewController: UIViewController {
    
     var topTableConstaint: NSLayoutConstraint? // ???????? как привезать Constaint
    
    private var dataSource: [SectionOfStudent] = SectionOfStudent.getStudents() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var wayOfGrouping: Grouping = .ungrouping {
        didSet {
           setGrouping(wayOfGrouping)
        }
    }
    
    var isSerchBarShow: Bool = false {
        didSet {
            searchBar.isHidden = !isSerchBarShow
            topTableConstaint?.constant = isSerchBarShow ? 40 : 0
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
    
    private let tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableHeaderView = nil
        table.tableFooterView = nil
        table.register(CodeStudentTableViewCell.self, forCellReuseIdentifier: "CodeStudentTableViewCell")
        return table
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var groupButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Group",
                                     style: .done,
                                     target: self,
                                     action: #selector(groupAction(sender:)))
        return button
    }()
    
    private lazy var searchButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search,
                                     target: self,
                                     action:  #selector(actionSearch(sender:)))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Students"
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        isSerchBarShow = false
    }
    
    private func setupUI() {
        
        self.navigationItem.rightBarButtonItems = [groupButton, searchButton]
        
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        
        let topTableConstaint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        self.topTableConstaint = topTableConstaint
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topTableConstaint
        ])
        
        NSLayoutConstraint.activate([
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func actionSearch(sender: Any) {
        isSerchBarShow = !isSerchBarShow
    }
    
    @objc func groupAction(sender: Any) {
        isSerchBarShow = false
        
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

extension StudentViewController: UITableViewDataSource {
    
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeStudentTableViewCell", for: indexPath) as! CodeStudentTableViewCell
        
        cell.setup(student: student)
        
        return cell
    }
}

extension StudentViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText)")
        let students = Student.all.filter { student in
            return student.name.lowercased().contains(searchText.lowercased())
        }
        print("students = \(students)")
        dataSource = [SectionOfStudent("Filter", students: students)]
    }
}
