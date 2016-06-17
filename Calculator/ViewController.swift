

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
    var secondNumber : Double = 0.0
    var firstNumber : Double = 0.0
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
        "ln": (prec: 3, rAssoc: true),
        "*": (prec: 3, rAssoc: false),
        "/": (prec: 3, rAssoc: false),
        "!": (prec: 3, rAssoc: false),
        "+": (prec: 2, rAssoc: false),
        "-": (prec: 2, rAssoc: false),
        ]
    
    func rpn(tokens : [String]) -> [String] {
        //        var rpn : [String] = []
        var t = LinkedList<String>()
        // var p : LinkedListNode<String>!
        
        var token = tokens.filter() {
            (x) -> Bool in
            !x.isEmpty
        }
        
        for i in 0...token.count-1 {
            // p.value = tokens[i]
            print(token[i])
            t.append(token[i])
            
        }
        
        var rpn = LinkedList<String>()
        //        var e : Array<String> = []
        //        e = rpn1
        //        var stack : [String] = [] // holds operators and left parenthesis
        var stac = LinkedList<String>()
        for i in 0...t.count-1  {
            switch t[i] {
            case "(":
                stac.append(t[i])// push "(" to stack
                print("push( ",stac)
            case ")":
                while !stac.isEmpty {
                    let op = stac.removeLast() // pop item from stack
                    if op == "(" {
                        print("discard",stac)
                        break // discard "("
                    } else {
                        rpn.append(op)
                        if t.next(i) == nil {
                        } // add operator to result
                            //print("add operator",rpn)
                        else {
                            break
                        }
                    }
                }
            default:
                if let o1 = opa[t[i]] { // token is an operator?
                    if stac.count > 0 {
                        for op in 0...stac.count - 1 {
                            //print("reverse",stac.reverse())
                            if let o2 = opa[stac[stac.count - 1 - op]] {
                                if !(o1.prec > o2.prec || (o1.prec == o2.prec && o1.rAssoc)) {
                                    // top item is an operator that needs to come off
                                    rpn.append(stac.removeLast()) // pop and add it to the result
                                    print("")
                                    print("o1.prec ",o1.prec," o2.prec ",o2.prec," o1.rassoc",o1.rAssoc)
                                    print("")
                                    print("h",rpn)
                                    //continue
                                }
                            }
                            break
                        }
                    }
                    stac.append(t[i]) // push operator (the new one) to stack
                    print("new",stac)
                } else { // token is not an operator
                    //                    while
                    rpn.append(t[i])
                    // add operand to result
                    print("add operand",rpn)
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
        var j : [String] = []
        if rpn.count > 0 {
            for i in 0...rpn.count - 1 {
                j.append(rpn.nodeAtIndex(i)!.value)
            }
        }
        
        if stac.count > 0 {
            for i in 0...stac.count - 1 {
                j.append(stac.nodeAtIndex(stac.count - 1 - i)!.value)
            }
        }
        print("k",rpn)
        print(stac.reverse())
        //print(rpn + stac.reverse())
        //return rpn + stac
        return j
    }
    
    
    
    //@IBOutlet var calculatorDisplay: UILabel!
    
    func numberTapped(sender: UIButton) {
        
        let number = sender.currentTitle!
        stack += number
        
        if isTypingNumber {
            calculatorDisplay.text = stack//calculatorDisplay.text! + number
        } else {
            calculatorDisplay.text = stack//number
            isTypingNumber = true
        }
    }
    
    func calculationTapped(sender: UIButton) {
        isTypingNumber = false
        stack += " "
        //        firstNumber = Int(calculatorDisplay.text!)!
        operation = sender.currentTitle!
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
    func equalTapped(sender: UIButton) {
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
        for itr in 0...lastIndex {
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
                tem[itr] != "ln" &&
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
                    tem[itr] == "/" ||
                    tem[itr] == "*" ||
                    tem[itr] == "+" ||
                    tem[itr] == "-") {
                    
                    print("2")
                    j = 2
                }
                else if
                    tem[itr] == "√" ||
                        tem[itr] == "ln" ||
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
                    stack.removeAll()
                }
                else {
                    print("else??")
                    if j == 2 {
                        secondNumber = t.popLast()!
                        firstNumber = t.popLast()!
                        print("second",secondNumber,"first",firstNumber,"operator",tem[itr])
                        if tem[itr] == "^" {
                            result = pow(Double(firstNumber),Double(secondNumber))
                        }
                        else if tem[itr] == "*" {
                            result = secondNumber * firstNumber
                        }
                        else if tem[itr] ==  "/" {
                            result = firstNumber / secondNumber
                        }
                        else if tem[itr] == "+" {
                            result = secondNumber + firstNumber
                        }
                        else if tem[itr] == "−" {
                            result =  firstNumber - secondNumber
                            //result = firstNumber
                        }
                        else {
                            calculatorDisplay.text = "error"
                            stack.removeAll()
                        }
                    }
                    else {
                        secondNumber = t.popLast()!
                        print("first",secondNumber)
                        if tem[itr] == "√" {
                            result = sqrt(secondNumber)
                        }
                        else if tem[itr] == "sin" {
                            result =  sin(secondNumber * M_PI / 180)
                        }
                        else if tem[itr] == "cos" {
                            result = cos(secondNumber * M_PI / 180)
                        }
                        else if tem[itr] == "tan" {
                            result = tan(secondNumber * M_PI / 180)
                        }
                        else if tem[itr] == "1/n" {
                            result = 1.0 / secondNumber
                        }
                        else if tem[itr] == "!" {
                            result = factorial(secondNumber)
                        }
                        else if tem[itr] == "ln" {
                            result = log(secondNumber) // log(secondNumber)
                        }
                        else {
                            calculatorDisplay.text = "error"
                            stack.removeAll()
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
            stack.removeAll()
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
    
    func backspaceTapped(sender: UIButton) {
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
    
    func clearTapped(sender: UIButton) {
        //stack = ""
        stack.removeAll(keepCapacity: false)
        calculatorDisplay.text?.removeAll()// = ""
    }
    
    var calculatorDisplay = UILabel(frame: CGRectMake(10,10,200,20))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")!.drawInRect(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.view.addSubview(calculatorDisplay)
        
        var factorial = UIButton(frame: CGRectMake(35,10,40,40))
        factorial.setTitle("!", forState: UIControlState.Normal)
        factorial.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(factorial)
        
        var square = UIButton(frame: CGRectMake(35,65,40,40))
        square.setTitle("^", forState: UIControlState.Normal)
        square.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(square)
        
        var radical = UIButton(frame: CGRectMake(35,110,40,40))
        radical.setTitle("√", forState: UIControlState.Normal)
        radical.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(radical)
        
        var clear = UIButton(frame: CGRectMake(35,155,40,40))
        clear.setTitle("C", forState: UIControlState.Normal)
        clear.addTarget(self, action: "clearTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(clear)
        
        var sin = UIButton(frame: CGRectMake(80,10,40,40))
        sin.setTitle("sin", forState: UIControlState.Normal)
        sin.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(sin)
        
        var left = UIButton(frame: CGRectMake(80,65,40,40))
        left.setTitle("(", forState: UIControlState.Normal)
        left.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(left)
        
        var right = UIButton(frame: CGRectMake(80,110,40,40))
        right.setTitle(")", forState: UIControlState.Normal)
        right.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(right)
        
        var back = UIButton(frame: CGRectMake(80,155,40,40))
        back.setTitle("⬅︎", forState: UIControlState.Normal)
        back.addTarget(self, action: "backspaceTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(back)
        
        var cos = UIButton(frame: CGRectMake(125,10,40,40))
        cos.setTitle("cos", forState: UIControlState.Normal)
        cos.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(cos)
        
        var num7 = UIButton(frame: CGRectMake(125,65,40,40))
        num7.setTitle("7", forState: UIControlState.Normal)
        num7.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num7)
        
        var num8 = UIButton(frame: CGRectMake(125,110,40,40))
        num8.setTitle("8", forState: UIControlState.Normal)
        num8.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num8)
        
        var num9 = UIButton(frame: CGRectMake(125,155,40,40))
        num9.setTitle("9", forState: UIControlState.Normal)
        num9.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num9)
        
        var divide = UIButton(frame: CGRectMake(125,155,40,40))
        divide.setTitle("/", forState: UIControlState.Normal)
        divide.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(divide)
        
        var tan = UIButton(frame: CGRectMake(170,10,40,40))
        tan.setTitle("tan", forState: UIControlState.Normal)
        tan.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(tan)
        
        var num4 = UIButton(frame: CGRectMake(170,65,40,40))
        num4.setTitle("4", forState: UIControlState.Normal)
        num4.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num4)
        
        var num5 = UIButton(frame: CGRectMake(170,110,40,40))
        num5.setTitle("5", forState: UIControlState.Normal)
        num5.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num5)
        
        var num6 = UIButton(frame: CGRectMake(170,155,40,40))
        num6.setTitle("6", forState: UIControlState.Normal)
        num6.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num6)
        
        var multiply = UIButton(frame: CGRectMake(170,155,40,40))
        multiply.setTitle("*", forState: UIControlState.Normal)
        multiply.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(multiply)
        
        var reciprocal = UIButton(frame: CGRectMake(215,10,40,40))
        reciprocal.setTitle("1/n", forState: UIControlState.Normal)
        reciprocal.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(reciprocal)
        
        var num1 = UIButton(frame: CGRectMake(215,65,40,40))
        num1.setTitle("1", forState: UIControlState.Normal)
        num1.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num1)
        
        var num2 = UIButton(frame: CGRectMake(215,110,40,40))
        num2.setTitle("2", forState: UIControlState.Normal)
        num2.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num2)
        
        var num3 = UIButton(frame: CGRectMake(215,155,40,40))
        num3.setTitle("3", forState: UIControlState.Normal)
        num3.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num3)
        
        var minus = UIButton(frame: CGRectMake(215,155,40,40))
        minus.setTitle("-", forState: UIControlState.Normal)
        minus.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(minus)
        
        var ln = UIButton(frame: CGRectMake(260,10,40,40))
        ln.setTitle("ln", forState: UIControlState.Normal)
        ln.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(ln)
        
        var num0 = UIButton(frame: CGRectMake(260,65,40,40))
        num0.setTitle("0", forState: UIControlState.Normal)
        num0.addTarget(self, action: "numberTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(num0)
        
        var dot = UIButton(frame: CGRectMake(260,110,40,40))
        dot.setTitle(".", forState: UIControlState.Normal)
        dot.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(dot)
        
        var equal = UIButton(frame: CGRectMake(260,155,40,40))
        equal.setTitle("=", forState: UIControlState.Normal)
        equal.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(equal)
        
        var plus = UIButton(frame: CGRectMake(260,155,40,40))
        plus.setTitle("+", forState: UIControlState.Normal)
        plus.addTarget(self, action: "calculationTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(plus)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
