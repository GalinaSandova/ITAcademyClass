//
//  ViewController.swift
//  CalculatorClassWork
//
//  Created by Galka on 02.11.2021.
//

import UIKit

class StoryboardedCalculatorViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var resultText: String = "0" {
        didSet {
            resultLabel.text = resultText
        }
    }
    
    var lastDigital: Double?
    var lastAction: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultText = "0"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for view in self.view.subviews {
            if view is UIButton {
                let min = min(view.frame.size.height, view.frame.size.width)
                view.layer.cornerRadius =  min / 2
            }
        }
    }
    
   
    @IBAction func digitButtonTapped(_ digitButton: UIButton) {
        updateResultText (with: String(digitButton.tag))
    }
        
        func updateResultText (with newText: String) {
        if
            resultText == "0" && newText == "0"
        {
            return
        }
        if resultText == "0" {
           resultText = newText
            
            return
        }
        
     
        if resultText.count >= 9 {
            return
        }
        resultText += newText
        print("Digit button: \(newText)")
    }
    
    @IBAction func plusMinusButtonTapped(_ sender: UIButton) {
        if resultText == "0" {
            return
        }
        if resultText.contains("-") {
            resultText.remove(at: resultText.startIndex)
        } else {
            resultText = "-" + resultText
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        resultText = "0"
        lastAction = nil
        lastDigital = nil
    }
    
    @IBAction func commaButtonTapped(_ sender: UIButton) {
        if resultText.contains(",") {
            return
        } else {
            resultText = resultText + ","
        }
    }
    
    @IBAction func actionButtonTapped(_ actionButton: UIButton) {
        
        switch actionButton.tag {
        case 1,2,3,4: // /,*,-,+
            guard let lastDigital = lastDigital,
                  let lastAction = lastAction,
                  let curentDigital = Double(resultLabel.text ?? "0") else {
                      lastAction = actionButton.tag
                      lastDigital = Double(resultLabel.text ?? "")
                      break
                  }
            
            let rezult = doAction(first: lastDigital,
                                  second: curentDigital,
                                  action: lastAction)
            resultText = String(rezult)
            
            break
        case 5: // =
            guard let lastDigital = lastDigital,
                  let lastAction = lastAction,
                  let curentDigital = Double(resultText) else {
                      return
                  }
            let rezult = doAction(first: lastDigital,
                                  second: curentDigital,
                                  action: lastAction)
            resultText = String(rezult)
            self.lastAction = nil
            break
        default:
            return
        }
        
        // Clean
        let temp = resultText
        resultText = ""
        resultLabel.text = temp
    }
    
    func doAction(first: Double, second: Double, action: Int) -> Double {
        var rezult: Double = 0.0
        
        switch action {
        case 1: // /
            rezult = first / second
        case 2: // *
            rezult = first * second
        case 3: // -
            rezult = first - second
        case 4: // +
            rezult = first + second
        default: return 0
        }
        
        return rezult
    }
    
}
