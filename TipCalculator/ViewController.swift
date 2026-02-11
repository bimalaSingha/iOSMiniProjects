//
//  ViewController.swift
//  TipCalculator
//
//  Created by K Bimala Singha on 21/01/26.
//

import UIKit

class TipCalculatorViewController: UIViewController {

//    // UI Components
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 25
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    
    ///
    private let billTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Bill Amount"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        tf.textAlignment = .center
        tf.font = .systemFont(ofSize: 20)
        return tf
    }()

    private let tipSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 0
        return slider
    }()

    private let tipPercentLabel: UILabel = {
        let label = UILabel()
        label.text = "Tip: 0%"
        label.textAlignment = .center
        return label
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Total: "
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createDismissKeyboardGesture()
    }

    //Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Tip Calculator"
        
        // Add subviews
        view.addSubview(stackView)
        stackView.addArrangedSubview(billTextField)
        stackView.addArrangedSubview(tipPercentLabel)
        stackView.addArrangedSubview(tipSlider)
        stackView.addArrangedSubview(resultLabel)

        // Constraints
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

        // Actions
        tipSlider.addTarget(self, action: #selector(calculateTip), for: .valueChanged)
        billTextField.addTarget(self, action: #selector(calculateTip), for: .editingChanged)
    }
    
    
   //Logic
    @objc private func calculateTip() {
        // 1. Get Input
        guard let billText = billTextField.text, let billAmount = Double(billText) else {
            resultLabel.text = "Total: Rs 0.00"
            return
        }

        // 2. Math
        let tipPercentage = Double(tipSlider.value)
        let tipAmount = billAmount * (tipPercentage / 100)
        let totalAmount = billAmount + tipAmount

        // 3. Formatting
        tipPercentLabel.text = String(format: "Tip: %.0f%%", tipPercentage)
        resultLabel.text = String(format: "Tip: Rs %.2f\nTotal: Rs %.2f", tipAmount, totalAmount)
        
        // Extra Challenge: Color change based on tip %
        updateUIStyle(percentage: tipPercentage)
    }

    private func updateUIStyle(percentage: Double) {
        if percentage < 10 {
            resultLabel.textColor = .systemRed
        } else if percentage < 20 {
            resultLabel.textColor = .blue
        } else {
            resultLabel.textColor = .systemGreen
        }
    }

    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
}
 


#Preview{
    TipCalculatorViewController()
}
