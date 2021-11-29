//
//  EmptyListViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/28/21.
//

import UIKit

class EmptyListViewController: UIViewController  {
  

    private var dataSource: [Student] = []
    
    private let addStudentButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add student", for: .normal)
        // button.tintColor = .label
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.tableHeaderView = nil
        table.tableFooterView = nil
        table.register(CodeStudentTableViewCell.self, forCellReuseIdentifier: "CodeStudentTableViewCell")
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Selected students"
        tableView.dataSource = self
        self.view.backgroundColor = .systemBackground
        setupUI()
        addStudentButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let vc = StudentViewController()
        
        vc.studentDelegate = self //pushButton

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        
        self.view.addSubview(tableView)
        self.view.addSubview(addStudentButton)
        addStudentButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        //addStudentButton.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.addStudentButton.topAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addStudentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addStudentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
}

    

extension EmptyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let student = dataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CodeStudentTableViewCell", for: indexPath) as! CodeStudentTableViewCell
        
        cell.setup(student: student)
        
        return cell
    }
}
extension EmptyListViewController: StudentProtocol {
    func selectStudent(viewContoller: UIViewController, student: Student) {
        print("selectStudent student: \(student)")
        dataSource.append(student)
        tableView.reloadData()
        self.navigationController?.popViewController(animated: true)
    }
    
    func selectStudent(viewContoller: UIViewController, name: String) {
        print("selectStudent name: \(name)")
    }
}
