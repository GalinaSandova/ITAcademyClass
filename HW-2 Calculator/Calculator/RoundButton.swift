//
//  RoundButton.swift
//  Calculator
//
//  Created by Galka on 27.10.2021.
//

import UIKit

@IBDesignable class RoundButton: UIButton
{
    @IBInspectable var symbol: String = ""
    @IBInspectable var toDo: Bool = true
    
    // Вызывается, когда кнопка меняет свои размеры
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }

    func updateCornerRadius() {
        let min = min(frame.size.height, frame.size.width)
        layer.cornerRadius =  min / 2
    }
}
