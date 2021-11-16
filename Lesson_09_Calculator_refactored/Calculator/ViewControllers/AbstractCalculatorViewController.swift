//
//  AbstractCalculatorViewController.swift
//  Calculator
//
//  Created by Nickolai Nikishin on 13.11.21.
//

import UIKit

class AbstractCalculatorViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    let calculatorLogic = CalculatorLogic()
    
    // MARK: - Select buttons
    
    private var selectButton: UIButton? {
//        willSet {
//            selectButton?.isSelected = false
//            newValue?.isSelected = true
//        }
        didSet {
            selectButton?.isSelected = true
            oldValue?.isSelected = false
        }
    }
    
    // MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculatorLogic.parentVC = self
    }
    
    // MARK: - IBActions
    
    @IBAction func digitButtonTapped(_ digitButton: UIButton) {
        calculatorLogic.updateDisplayText(with: String(digitButton.tag))
    }
    
    @IBAction func binaryOperandButtonTapped(_ sender: UIButton) {
        guard let binaryOperand = BinaryOperand(rawValue: sender.tag) else {
            print("unknown operand")
            return
        }
        selectButton = sender
        calculatorLogic.executeBinaryOperand(binaryOperand: binaryOperand)
    }
    
    @IBAction func unaryOperatorButtonTapped(_ sender: UIButton) {
        guard let unaryOperand = UnaryOperand(rawValue: sender.tag) else {
            print("unknown operand")
            return
        }
        
        calculatorLogic.executeUnaryOperand(unaryOperand: unaryOperand)
    }
    
    @IBAction func equalOperatorButtonTapped(_ sender: Any) {
        selectButton = nil
        calculatorLogic.executeEqualOperand()
    }
    
    @IBAction func decimalSeparatorButtonTapped(_ sender: Any) {
        calculatorLogic.executeDecimal()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        selectButton = nil
        calculatorLogic.executeClear()
    }
}
