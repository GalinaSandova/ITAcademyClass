//
//  ViewController.swift
//  Calculator
//
//  Created by Galka on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resalt: UILabel!
    var caunter = 0
    {
        didSet  {
            print(caunter)
            updateLabel()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func buttonTapped(_ sender: Any) {
        if let sender = sender as? UIButton {
            caunter = sender.tag }
    }
    
 
    func updateLabel() {
        resalt.text = String(caunter)
     

}
}

