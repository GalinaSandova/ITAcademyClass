//
//  UneryOperatorButton.swift
//  Calculator
//
//  Created by Halina Sandova on 11/15/21.
//

import UIKit

class UneryOperatorButton: RoundedButton {
    let defaultColor = UIColor.systemGray
    let selectedColor = UIColor.white
    

    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? selectedColor : defaultColor
        }
    }
}
