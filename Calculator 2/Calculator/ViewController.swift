//
//  ViewController.swift
//  Calculator
//
//  Created by Christiaan Lam on 05-07-16.
//  Copyright © 2017 Air Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // infer an instance of the calculator module
    fileprivate var brain = CalculatorBrain()
    
    // what is currently on the display?
    @IBOutlet fileprivate weak var display: UILabel!
    
    // is the user typing or is it the first digit?
    fileprivate var bUserIsTyping = false
    
    // Value of the display
    // turn string into double and vice versa
    fileprivate var displayValue: Double{
        get {
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    // touchDigit - when a button with a digit is released
    // in: sender - string with the value of the button
    @IBAction fileprivate func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if bUserIsTyping{
            // already typing, then concatenate the pressed button
            let sCurrentDisplay = display.text!
            display.text = sCurrentDisplay + digit
        }
        else{
            // replace the zero with the digit
            display.text = digit
        }
        bUserIsTyping = true
    }
    
    // doMath - when a button with a mathematical value is released
    // in: sender - string with math sumbol
    @IBAction fileprivate func doMath(_ sender: UIButton) {
        if bUserIsTyping{
            brain.setOperand(displayValue)
            bUserIsTyping = false
        }
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(mathSymbol)
        }
        displayValue = brain.result
    }
    
    
}
