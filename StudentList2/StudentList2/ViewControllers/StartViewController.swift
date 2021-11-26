//
//  StartViewController.swift
//  StudentList2
//
//  Created by Halina Sandova on 11/26/21.
//

import UIKit

class StartViewController: UIViewController {

    @IBAction func welcomeButton(_ sender: Any) {
        let vc = StudentViewController()
        vc.studentDelegate = self
       self.navigationController?.pushViewController(vc, animated: true)
        
        // Open from present
        //let nc = UINavigationController(rootViewController: vc)
        //self.present(nc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var welcomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
}

extension StartViewController: StudentProtocol {
    
    func selectStudent(viewContoller: UIViewController, name: String) {
        print("StartViewController \(name)")
        welcomeButton.setTitle(name, for: .normal)
        
        self.navigationController?.popViewController(animated: true)
        
        //viewContoller.dismiss(animated: true, completion: nil)
    }
    
}

