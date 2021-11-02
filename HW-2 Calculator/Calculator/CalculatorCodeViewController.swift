//
//  CalculatorCodeViewController.swift
//  Calculator
//
//  Created by Galka on 01.11.2021.
//

import UIKit

class ColorConstant {
    static let grayButton: UIColor = UIColor(red: 50.0/255.0, green: 51.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    static let lithGrayButton: UIColor = UIColor(red: 164.0/255.0, green: 165.0/255.0, blue: 166.0/255.0, alpha: 1.0)
    static let orangeButton: UIColor = UIColor(red: 250.0/255.0, green: 159.0/255.0, blue: 43.0/255.0, alpha: 1.0)
}

class CalculatorCodeViewController: UIViewController {
    
    var counter: String = "0"
    {
        didSet  {
            print(counter)
            resaltLabel.text = counter.isEmpty ? "0" : counter
        }
    }
    
    private lazy var resaltLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView2: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView3: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView4: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var horizontalStackView5: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var acButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "ac"
        view.setTitle("AC", for: .normal)
        view.backgroundColor = ColorConstant.lithGrayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pmButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "+-"
        view.setTitle("+/-", for: .normal)
        view.backgroundColor = ColorConstant.lithGrayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var procButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "%"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.lithGrayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var devButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "/"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.orangeButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var umButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "*"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.orangeButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var minusButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "-"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.orangeButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var plusButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "+"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.orangeButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var equalButton: RoundButton = {
        let view = RoundButton()
        view.symbol = "="
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.orangeButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dotButton: RoundButton = {
        let view = RoundButton()
        view.symbol = ","
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c0Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "0"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c1Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "1"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c2Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "2"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c3Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "3"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c4Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "4"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c5Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "5"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c6Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "6"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c7Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "7"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c8Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "8"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var c9Button: RoundButton = {
        let view = RoundButton()
        view.symbol = "9"
        view.setTitle(view.symbol, for: .normal)
        view.backgroundColor = ColorConstant.grayButton
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(resaltLabel)
        self.view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        verticalStackView.addArrangedSubview(horizontalStackView3)
        verticalStackView.addArrangedSubview(horizontalStackView4)
        verticalStackView.addArrangedSubview(horizontalStackView5)
        
        horizontalStackView1.addArrangedSubview(acButton)
        horizontalStackView1.addArrangedSubview(pmButton)
        horizontalStackView1.addArrangedSubview(procButton)
        horizontalStackView1.addArrangedSubview(devButton)
        
        horizontalStackView2.addArrangedSubview(c7Button)
        horizontalStackView2.addArrangedSubview(c8Button)
        horizontalStackView2.addArrangedSubview(c9Button)
        horizontalStackView2.addArrangedSubview(umButton)

        horizontalStackView3.addArrangedSubview(c4Button)
        horizontalStackView3.addArrangedSubview(c5Button)
        horizontalStackView3.addArrangedSubview(c6Button)
        horizontalStackView3.addArrangedSubview(minusButton)
        
        horizontalStackView4.addArrangedSubview(c1Button)
        horizontalStackView4.addArrangedSubview(c2Button)
        horizontalStackView4.addArrangedSubview(c3Button)
        horizontalStackView4.addArrangedSubview(plusButton)
        
        horizontalStackView5.addArrangedSubview(c0Button)
        horizontalStackView5.addArrangedSubview(dotButton)
        horizontalStackView5.addArrangedSubview(equalButton)
        
        self.setUpConstraints()
    }
    
    func setUpConstraints () {
       
        // Add Constraints for resaltLabel
        NSLayoutConstraint.activate([
            self.resaltLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            self.resaltLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            self.resaltLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            self.resaltLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3)
        ])
        
        // Add Constraints for verticalStackView
        NSLayoutConstraint.activate([
            self.verticalStackView.topAnchor.constraint(equalTo: self.resaltLabel.bottomAnchor, constant: 50),
            self.verticalStackView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            self.verticalStackView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            self.verticalStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
        ])
        
        // // Add Constraints for dotButton and equalButton
        NSLayoutConstraint.activate([
            self.dotButton.widthAnchor.constraint(equalTo: self.c3Button.widthAnchor, multiplier: 1.0),
            self.equalButton.widthAnchor.constraint(equalTo: self.c3Button.widthAnchor, multiplier: 1.0)
        ])
    }
    
    @objc func buttonTapped(_ sender: Any) {
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
                resaltLabel.text = "I don't know"
            case "+","-","/","*","%":
                let priview = counter
                counter = ""
                resaltLabel.text = priview
            default: break
            }
        }
    }
}
