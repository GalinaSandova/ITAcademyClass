//
//  StartViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/26/21.
//

import UIKit

class StartViewController: UIViewController {
    enum ButtonTapped {
        case push
        case present
    }
    var buttonTapped: ButtonTapped? = nil
    
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var presentButton: UIButton!

    @IBAction func pushButton(_ sender: Any) {
        let vc = StudentViewController()
        // let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.studentDelegate = self //pushButton
        self.buttonTapped = .push
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func presentButton(_ sender: Any) {
        let vc = StudentViewController()
        vc.studentDelegate = self
        self.buttonTapped = .present
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
}

extension StartViewController: StudentProtocol {
    
    func selectStudent(viewContoller: UIViewController, name: String) {
        print("StartViewController \(name)")
        if buttonTapped == .push {
            pushButton.setTitle(name, for: .normal)
            self.navigationController?.popViewController(animated: true)
        } else {
            presentButton.setTitle(name, for: .normal)
            viewContoller.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension UIButton: StudentProtocol {
    func selectStudent(viewContoller: UIViewController, name: String) {
        self.setTitle(name, for: .normal)
    }
}
