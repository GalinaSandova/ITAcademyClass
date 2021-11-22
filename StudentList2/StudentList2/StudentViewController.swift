//
//  StudentViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/21/21.
//

import UIKit

class StudentViewController: UIViewController {
    
    private var dataSource: [SectionOfStudent] = SectionOfStudent.getStudents() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: UITableView.Style.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CodeStudentTableViewCell.self, forCellReuseIdentifier: "CodeStudentTableViewCell")
        return table
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Students"
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        self.view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
        ])
        
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
}
