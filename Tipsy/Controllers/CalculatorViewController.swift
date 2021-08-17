//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var splitNumberStepper: UIStepper!
    
    var tipPercentage:Double = 0.0
    var valPerPerson:Double = 0.0
    var textForAdvice:String?

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        if sender.currentTitle == "0%"{
            tipPercentage = 0.0
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }else if sender.currentTitle == "10%"{
            tipPercentage = 0.1
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
        }else{
            tipPercentage = 0.2
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        billTextField.endEditing(true)
        splitNumberLabel.text = String(format: "%.f", splitNumberStepper.value)
    }
    
    @IBAction func calculatedPressed(_ sender: UIButton) {
        let billVall = CFStringGetDoubleValue(billTextField.text as CFString?)
        valPerPerson = (billVall + (billVall * tipPercentage)) / splitNumberStepper.value
        textForAdvice = "Split Between \(String(format: "%.0f", splitNumberStepper.value)) people, with \(tipPercentage*100)% tip"
        performSegue(withIdentifier: "goToResults", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalCalculated = String(format: "%.2f", valPerPerson)
            destinationVC.textAdvice = textForAdvice
        }
    }
}

