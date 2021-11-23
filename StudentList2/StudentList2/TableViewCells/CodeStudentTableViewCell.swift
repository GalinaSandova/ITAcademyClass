//
//  CodeStudentTableViewCell.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/22/21.
//

import UIKit

class CodeStudentTableViewCell: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let studentImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func setupUI() {
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(studentImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: studentImageView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            studentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            studentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            studentImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            studentImageView.heightAnchor.constraint(equalToConstant: 72),
            studentImageView.widthAnchor.constraint(equalToConstant: 72),
        ])
    }
    
    func setup(student: Student) {
        nameLabel.text = student.name
        studentImageView.image = UIImage(named: student.avatar ?? "user") ?? UIImage(named: "user")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
