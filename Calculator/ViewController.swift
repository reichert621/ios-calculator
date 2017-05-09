//
//  ViewController.swift
//  Calculator
//
//  Created by Alex Reichert on 5/7/17.
//  Copyright © 2017 Alex Reichert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsTyping = false
    
    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsTyping {
            let currentDisplayText = display.text!
            
            display.text = currentDisplayText + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }
    
    @IBAction func performOperation(sender: UIButton) {
        userIsTyping = false
        
        if let mathSymbol = sender.currentTitle {
            if mathSymbol == "π" {
                display.text = String(M_PI)
            }
        }
    }
}

