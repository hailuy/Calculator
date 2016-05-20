
//  ViewController.swift
//  Calculator
//
//  Copyed by itria on 16/5/13.
//  Copyright © 2016年 Karidon. All rights reserved.
//
import Foundation
//import Cocoa
import UIKit

class ViewController: UIViewController {
    
    // boolean to check whether typing a num or pressing an operation
    var isTypingNumber = false
    var firstNumber : Double = 0.0
    var secondNumber : Double = 0.0
    var operation = ""
    var stack : String = ""
//    var operandStack = Array<Double>()
    
    let opa = [
        "(": (prec: 5, rAssoc: false),
        ")": (prec: 5, rAssoc: false),
        "^": (prec: 4, rAssoc: true),
        "√": (prec: 4, rAssoc: true),
        "sin": (prec: 3, rAssoc: false),
        "cos": (prec: 3, rAssoc: false),
        "tan": (prec: 3, rAssoc: false),
        "1/n": (prec: 3, rAssoc: false),
        "log": (prec: 3, rAssoc: false),
        "*": (prec: 3, rAssoc: false),
        "/": (prec: 3, rAssoc: false),
        "!": (prec: 3, rAssoc: false),
        "+": (prec: 2, rAssoc: false),
        "-": (prec: 2, rAssoc: false),
    ]
    
    func rpn(tokens : [String]) -> [String] {
//        var rpn : [String] = []
        var rpn : [String] = []
//        var e : Array<String> = []
//        e = rpn1
//        var stack : [String] = [] // holds operators and left parenthesis
        var stac : [String] = []
        for tok in tokens {
            switch tok {
            case "(":
                stac += [tok] // push "(" to stack
            case ")":
                while !stac.isEmpty {
                    let op = stac.removeLast() // pop item from stack
                    if op == "(" {
                        break // discard "("
                    } else {
                        rpn += [op] // add operator to result
                    }
                }
            default:
                if let o1 = opa[tok] { // token is an operator?
                    for op in stac.reverse() {
                        if let o2 = opa[op] {
                            if !(o1.prec > o2.prec || (o1.prec == o2.prec && o1.rAssoc)) {
                                // top item is an operator that needs to come off
                                rpn += [stac.removeLast()] // pop and add it to the result
                                continue
                            }
                        }
                        break
                    }
                    
                    stac += [tok] // push operator (the new one) to stack
                } else { // token is not an operator
//                    while
                    rpn += [tok] // add operand to result
                }
            }
        }
//            print(stack)
//        while stack != [] {
//            stack1.append(stack.popLast()!)
//        }
//        print(rpn)
//        while rpn != [] {
//            rpn1.append(rpn.popLast()!)
//        }
        print(rpn + stac)
        return rpn + stac
        
    }
    
    
    
    @IBOutlet var calculatorDisplay: UILabel!
   
    @IBAction func numberTapped(sender: AnyObject) {
        
        let number = sender.currentTitle!!
        stack += number
        
        if isTypingNumber {
            calculatorDisplay.text = stack//calculatorDisplay.text! + number
        } else {
            calculatorDisplay.text = stack//number
            isTypingNumber = true
        }
    }
    
    @IBAction func calculationTapped(sender: AnyObject) {
        isTypingNumber = false
        stack += " "
//        firstNumber = Int(calculatorDisplay.text!)!
        operation = sender.currentTitle!!
        stack += operation
        calculatorDisplay.text = stack//calculatorDisplay.text! + operation
        stack += " "
    }
    func factorial(n: Double) -> Double {
        if n >= 0 {
            return n == 0 ? 1 : n * self.factorial(n - 1)
        } else {
            return 0 / 0
        }
    }
    @IBAction func equalTapped(sender: AnyObject) {
        isTypingNumber = false
        let arr : [String] = stack.componentsSeparatedByString(" ")// = stack.joinWithSeparator(" ")
//            arr.componentsSeparatedByString(" ")
        var tem : [String] = rpn(arr)//
        tem = tem.filter() {
            (x) -> Bool in
            !x.isEmpty
        }
        tem = tem.filter({$0 != "("})
//        var arr = rpn.spli
//        arr.
        var t : [Double] = [] //[(0.0),(8.0)]
        var j : Int = 0
//        var tem : [String]
        let lastIndex : Int = tem.endIndex.advancedBy(-1)
        
        var result : Double = 0.0
        for var itr : Int = 0;lastIndex >= itr;itr++ {
//            arr = tem
//            lastIndex
//            var lastInde = tem.endIndex.advancedBy(-1)
            if (tem[itr] != "^" &&
                tem[itr] != "*" &&
                tem[itr] != "/" &&
                tem[itr] != "+" &&
                tem[itr] != "-" &&
                tem[itr] != "√" &&
                tem[itr] != "sin" &&
                tem[itr] != "cos" &&
                tem[itr] != "tan" &&
                tem[itr] != "1/n" &&
                tem[itr] != "log" &&
                tem[itr] != "!") {
                    print(tem[itr])
//                    if t[0] == 0 {
//                        t[0] = (tem[lastIndex] as NSString).doubleValue
//                    }
//                    else {
//                    if tem[itr] == "e" {
//                        
//                    }
//                    
                    t.append((tem[itr] as NSString).doubleValue)
//                    }
                    print(tem)
//                    print(tem)
                    print(t)
//                    var ope : String = arr[lastIndex]
//                    var lastInde = tem.endIndex.advancedBy(-1)
//                    tem = tem.removeAtIndex(lastInde)
//                    tem = tem.substringToIndex(lastInde)
//                    arr = tem.componentsSeparatedByString(" ")
//                    firstNumber = (arr[arr.endIndex.advancedBy(-1)] as NSString).doubleValue
//                    arr = tem.componentsSeparatedByString(" ")
//                    secondNumber = (arr[arr.endIndex.advancedBy(-1)] as NSString).doubleValue
//                                       tem = tem.dropLast(1)
//                    t = tem.popLast()
                    continue
            }
//                
//            else if
//                arr[lastIndex] == "√" ||
//                arr[lastIndex] == "sin" ||
//                arr[lastIndex] == "cos" ||
//                arr[lastIndex] == "tan" ||
//                arr[lastIndex] == "ln" ||
//                arr[lastIndex] == "log" ||
//                arr[lastIndex] == "!" {
//                switch operation {
//                    case "√":
//                        if operandStack.count >= 1 {
//                            return sqrt(self.operandStack.removeLast())
//                        }
//                    
//                    case "sin":
//                        if operandStack.count >= 1 {
//                            return sin(self.operandStack.removeLast() * M_PI / 180)
//                    }
//                    
//                    case "cos":
//                        if operandStack.count >= 1 {
//                            return cos(self.operandStack.removeLast() * M_PI / 180)
//                        }
//                    
//                    case "tan":
//                        if operandStack.count >= 1 {
//                            return tan(self.operandStack.removeLast() * M_PI / 180)
//                        }
//                    
//                    case "log":
//                        if operandStack.count >= 1 {
//                            return log(self.operandStack.removeLast())
//                        }
//                    
//                    default:break
//                }
//            }
            else {
                
                print("1")
                if (tem[itr] == "^" ||
                    tem[itr] == "log" ||
                    tem[itr] == "/" ||
                    tem[itr] == "*" ||
                    tem[itr] == "+" ||
                    tem[itr] == "-") {
                        
                        print("2")
                        j = 2
                }
                else if
                    tem[itr] == "√" ||
                    tem[itr] == "sin" ||
                    tem[itr] == "cos" ||
                    tem[itr] == "tan" ||
                    tem[itr] == "1/n" ||
                    tem[itr] == "!" {
                        
                        print("3")
                        j = 1
                }
                if t.count < j {
                    calculatorDisplay.text = "error"
                }
                else {
                    print("else??")
                    if j == 2 {
                        firstNumber = t.popLast()!
                        secondNumber = t.popLast()!
                        print("first",firstNumber,"second",secondNumber,"tem[itr]",tem[itr])
                        if tem[itr] == "^" {
                            result = pow(Double(secondNumber),Double(firstNumber))
                        }
                        else if tem[itr] == "*" {
                            result = firstNumber * secondNumber
                        }
                        else if tem[itr] ==  "/" {
                            result = firstNumber / secondNumber
                        }
                        else if tem[itr] == "+" {
                            result = firstNumber + secondNumber
                        }
                        else if tem[itr] == "−" {
                            result = firstNumber - secondNumber
                        }
                        else if tem[itr] == "log" {
                            result = log(secondNumber) / log(firstNumber)
                        }
                    }
                    else {
                        firstNumber = t.popLast()!
                        print("first",firstNumber)
                        if tem[itr] == "√" {
                            result = sqrt(firstNumber)
                        }
                        else if tem[itr] == "sin" {
                            result =  sin(firstNumber * M_PI / 180)
                        }
                        else if tem[itr] == "cos" {
                            result = cos(firstNumber * M_PI / 180)
                        }
                        else if tem[itr] == "tan" {
                            result = tan(firstNumber * M_PI / 180)
                        }
                        else if tem[itr] == "1/n" {
                            result = 1.0 / firstNumber
                            
                        }
                        else if tem[itr] == "!" {
                            result = factorial(firstNumber)
                        }
                    }
                }
                t.append(result)
                print("result ",result)
                print("t ",t)
                continue
            }
        }
        if t.count == 1 {
            calculatorDisplay.text = "\(result)"
            stack.removeAll()
        }
        else {
            calculatorDisplay.text = "error"
        }

        
//        var temp : Double = (arr[lastIndex] as NSString).doubleValue
    
//        operandStack = Array(tem)
//        let result = operate(operandStack)
//        secondNumber = Int(calculatorDisplay.text!)!
        
//        if operation == "+" {
//            result = firstNumber + secondNumber
//        } else if operation == "*" {
//            result = firstNumber * secondNumber
//        } else if operation == "-" {
//            result = firstNumber - secondNumber
//        } else if operation == "/" {
//            result = firstNumber / secondNumber
//        }
//        
        
    }
    
    @IBAction func backspaceTapped(sender: AnyObject) {
//        stack.dropFirst()
//        let int = calculatorDisplay.text!.lengthOfBytesUsingEncoding(<#T##encoding: NSStringEncoding##NSStringEncoding#>) / 8
        var te : String = stack
//        var index = 0
//        var temp :String = ""\
        var i : Character = "?"
        if te.isEmpty == false {
            var lastInde = te.endIndex.advancedBy(-1)
            repeat {
                lastInde = te.endIndex.advancedBy(-1)
                i = te[lastInde]
                te = te.substringToIndex(lastInde) //or tem.removeAtIndex(tem.endIndex.predecessor())
                stack = te
            }while(i == " ");
        }
        
//        let s = tem[lastIndex]
        calculatorDisplay.text = stack
//        for var i = 0;i < (int - 1);i++ {
//            temp = tem.startIndex.advancedBy(i)
////            temp = tem[index]
//            calculatorDisplay.text = calculatorDisplay.text! + temp
//        }
    }
    
    @IBAction func clearTapped(sender: AnyObject) {
        stack = ""
        calculatorDisplay.text = ""
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
