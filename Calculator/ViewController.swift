//
//  ViewController.swift
//  Calculator
//
//  Created by Alex Reichert on 5/7/17.
//  Copyright © 2017 Alex Reichert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!

    private var userIsTyping = false

    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsTyping {
            let currentDisplayText = display.text!

            display.text = currentDisplayText + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }

    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    private var brain = CalculatorBrain()

    @IBAction private func performOperation(sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
        }

        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }

        displayValue = brain.result
    }
}

