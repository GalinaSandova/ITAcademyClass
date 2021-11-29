//
//  StudentProtocol.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/26/21.
//

import Foundation
import UIKit

protocol StudentProtocol {
    func selectStudent(viewContoller: UIViewController, name: String)
    func selectStudent(viewContoller: UIViewController, student: Student)
}
