//
//  ViewController.swift
//  Calculator
//
//  Created by tjiese on 16/5/13.
//  Copyright © 2016年 Karidon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var IsTypingNumber = false
    
    var firstNumber = 0
    
    var SecondNumber = 0
    
    var operation = ""
    
    @IBOutlet weak var calculatorDisplay: UILabel!

    @IBAction func numberTapped(sender: AnyObject) {
        
        var number = sender.currentTitle
        
        if IsTypingNumber {
            
            calculatorDisplay.text = calculatorDisplay.text! + number
            
        } else {
            
            calculatorDisplay.text = number
            
            IsTypingNumber = true
            
        }
        
    }
    
    @IBAction func calculationTapped(sender: AnyObject) {
        
        IsTypingNumber = false
        
        firstNumber = calculatorDisplay.text!.toInt()!
        
        operation = sender.currentTitle
        
    }
    
    @IBAction func equalTapped(sender: AnyObject) {
        
        IsTypingNumber = false
        
        var reselt = 0
        
        SecondNumber = calculatorDisplay.text!.toInt()!
        
        
        if operation == "+" {
            
            reselt = firstNumber + SecondNumber
            
        } else if operation == "*" {
            
            reselt = firstNumber * SecondNumber
        
        }
        
        calculatorDisplay.text = "\(result)"
        
    }
    
    @IBAction func priorTapped(sender: AnyObject) {
    
        
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

