//
//  ViewController.swift
//  Calculator
//
//  Created by Galka on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resalt: UILabel!
 
    var counter: String = "0"
    {
        didSet  {
            print(counter)
            resalt.text = counter.isEmpty ? "0" : counter
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if let sender = sender as? RoundButton {
            switch sender.symbol {
            case "1","2","3","4","5","6","7","8","9":
                if counter == "0" { counter = "" }
                counter += "\(sender.symbol)"
            case "0":
                if counter != "0" {
                    counter += "\(sender.symbol)"
                }
            case ",":
                if !counter.contains(",") {
                    counter += "\(sender.symbol)"
                }
            case "ac":
                counter = "0"
            case "+-":
                if counter == "0" { return }
                if counter == "0," { return }
                if counter.contains("-") {
                    counter.remove(at: counter.startIndex)
                } else {
                    counter.insert("-", at: counter.startIndex)
                }
            case "=":
                counter = ""
                resalt.text = "I don't know"
            case "+","-","/","*","%":
                let priview = counter
                counter = ""
                resalt.text = priview
            default: break
            }
        }
    }
}

