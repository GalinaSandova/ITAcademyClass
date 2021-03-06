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
        tableView.delegate = self
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        addStudentButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        dataSource = WADefaults.sh.students
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let vc = StudentViewController()
        vc.selectStudent = { [weak self] student, vc in
            self?.selectStudent(viewContoller: vc, student: student)
        }
        
        // vc.studentDelegate = self //pushButton
        
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
extension EmptyListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        // Trash action
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
                //self?.handleMoveToTrash()
            self?.dataSource.remove(at: indexPath.row)
            WADefaults.sh.students = self?.dataSource ?? []
            tableView.reloadSections(.init(integer: 0), with: .none)
            //tableView.reloadData()
                                        completionHandler(true)
        }
        trash.backgroundColor = .systemRed

        let configuration = UISwipeActionsConfiguration(actions: [trash])

        return configuration
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        let mover = dataSource.remove(at: sourceIndexPath.row)
        dataSource.insert(mover, at: destinationIndexPath.row)
        WADefaults.sh.students = self.dataSource 
    }
}

extension EmptyListViewController: StudentProtocol {
    func selectStudent(viewContoller: UIViewController, student: Student) {
        print("selectStudent student: \(student)")
        
        //let isStudent2 = dataSource.contains(where: {$0.name == student.name})
        let isStudent = dataSource.contains(where: { item in
            student.sex == item.sex
            && student.yearOfBirth == item.yearOfBirth
            && student.name == item.name
            && student.avatar == item.avatar
        })
        
        if isStudent == false {
            dataSource.append(student)
            WADefaults.sh.students = dataSource
            
            tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Student is in the list", preferredStyle: .alert)
            let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancelAlertAction)
            viewContoller.present(alert, animated: true, completion: nil)
        }
    }
    
    func selectStudent(viewContoller: UIViewController, name: String) {
        print("selectStudent name: \(name)")
    }
}

extension EmptyListViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
         dragItem.localObject = dataSource[indexPath.row]
         return [ dragItem ]
    }
    
    
}
