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
    
    //A dict containing all the operators
    let opa = [
        "(": (prec: 5, rAssoc: false),
        ")": (prec: 5, rAssoc: false),
        "^": (prec: 4, rAssoc: false),
        "√": (prec: 4, rAssoc: true),
        "sin": (prec: 4, rAssoc: true),
        "cos": (prec: 4, rAssoc: true),
        "tan": (prec: 4, rAssoc: true),
        "log": (prec: 4, rAssoc: true),
        "ln": (prec: 4, rAssoc: true),
        "*": (prec: 3, rAssoc: false),
        "/": (prec: 3, rAssoc: false),
        "!": (prec: 3, rAssoc: false),
        "+": (prec: 2, rAssoc: false),
        "-": (prec: 2, rAssoc: false)
    ]
    
    func rpn(tokens : [String]) -> [String] {
        var t = LinkedList<String>()
        
        //throw away all the blank space
        var token = tokens.filter() {
            (x) -> Bool in
            !x.isEmpty
        }
        
        //put [String] into LinkedList<String>()
        for i in 0...token.count-1 {
            print(token[i])
            t.append(token[i])
            
        }
        
        var rpn = LinkedList<String>()
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
                    } else {    //the added code(probably this area,can't really remember
                        rpn.append(op)
                        if t.next(i) == nil {
                        } // add operator to result
                        else {
                            break
                        }
                    }
                }
            default:
                if let o1 = opa[t[i]] { // token is an operator?
                    if stac.count > 0 {
                        for op in 0...stac.count - 1 {
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
                    rpn.append(t[i])
                    // add operand to result
                    print("add operand",rpn)
                }
            }
        }
        var j : [String] = []
        
        //put LinkedList<String>() back to [String]
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

//"." if input ".8" automatically change to "0.8",else just add the dot
    func dotTapped(sender: UIButton){
        isTypingNumber = false
        operation = sender.currentTitle!
        if stack == "" {
            stack += "0"
        }
        stack += operation
        calculatorDisplay.text = stack
    }

// push operarand to the stack    
    func numberTapped(sender: UIButton) {
        stack.removeAll()
        let number = sender.currentTitle!
        stack += number
        
        if isTypingNumber {
            calculatorDisplay.text = stack
        } else {
            calculatorDisplay.text = stack
            isTypingNumber = true
        }
    }
    
    //push opeartor to the stack
    func calculationTapped(sender: UIButton) {
        isTypingNumber = false
        stack += " "
        operation = sender.currentTitle!
        stack += operation
        calculatorDisplay.text = stack
        stack += " "
    }
    
    //factorial calculation,recursively
    func factorial(n: Double) -> Double {
        if n >= 0 {
            return n == 0 ? 1 : n * self.factorial(n - 1)
        } else {
            return 0
        }
    }
    
    //when tapped "=",start the calculation
    func equalTapped(sender: UIButton) {
        isTypingNumber = false
        
        //seperate every operator or operand in stack by " ",change them into postfix
        var tem : [String] = rpn(stack.componentsSeparatedByString(" "))
        
        //throw away " " and "("
        tem = tem.filter() {
            (x) -> Bool in
            !x.isEmpty
        }
        tem = tem.filter({$0 != "("})
        
        //if only 1 input,output directly
        if tem.count == 1 {
            calculatorDisplay.text = tem[0]
            return
        }
        
        var t : [Double] = []
        var j : Int = 0
        let lastIndex : Int = tem.endIndex.advancedBy(-1)
        
        var result : Double = 0.0
        for itr in 0...lastIndex {
            if (tem[itr] != "^" &&
                tem[itr] != "*" &&
                tem[itr] != "/" &&
                tem[itr] != "+" &&
                tem[itr] != "-" &&
                tem[itr] != "√" &&
                tem[itr] != "sin" &&
                tem[itr] != "cos" &&
                tem[itr] != "tan" &&
                tem[itr] != "log" &&
                tem[itr] != "ln" &&
                tem[itr] != "!") {
                print("tem[itr]",tem[itr])
                t.append((tem[itr] as NSString).doubleValue)
                print("tem",tem)
                print("t",t)
                continue
            }
            else {
                
                //needs 2 operands or 1 operand
                
                print("1")
                if (tem[itr] == "^" ||
                    tem[itr] == "/" ||
                    tem[itr] == "*" ||
                    tem[itr] == "+" ||
                    tem[itr] == "-") {
                    
                    print("2??")
                    j = 2
                }
                else if
                    tem[itr] == "√" ||
                    tem[itr] == "ln" ||
                    tem[itr] == "log" ||
                    tem[itr] == "sin" ||
                    tem[itr] == "cos" ||
                    tem[itr] == "tan" ||
                    tem[itr] == "!" {
                    
                    print("3")
                    j = 1
                }
                
                //if operand is not enough,error,else do the calculation
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
                        else if tem[itr] == "-" {
                            result =  firstNumber - secondNumber
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
                        else if tem[itr] == "log" {
                            result = log(secondNumber) / log(10)
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
                        else if tem[itr] == "!" {
                            result = factorial(secondNumber)
                        }
                        else if tem[itr] == "ln" {
                            result = log(secondNumber)
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
            if result % 1 == 0 {
                stack = String(format:"%.0f", result)
                calculatorDisplay.text = stack
            }
            else {
                calculatorDisplay.text = "\(result)"
                stack = "\(result)"
            }
            if calculatorDisplay.text == "0" {
                stack.removeAll()
            }
        }
        else {
            calculatorDisplay.text = "error"
            stack.removeAll()
        }
        
    }
    
    //in the vaild range,each time kill one char
    func backspaceTapped(sender: UIButton) {
        var te : String = stack
        var i : Character = "?"
        if te.isEmpty == false {
            var lastInde = te.endIndex.advancedBy(-1)
            repeat {
                lastInde = te.endIndex.advancedBy(-1)
                i = te[lastInde]
                te = te.substringToIndex(lastInde)
                stack = te
            }while(i == " ");
        }
        
        calculatorDisplay.text = stack
    }
    
    func clearTapped(sender: UIButton) {
        stack.removeAll(keepCapacity: false)
        calculatorDisplay.text?.removeAll()
    }
    
    var calculatorDisplay : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = self.view.frame.size.width / 5
        let height = (self.view.frame.size.height - 200) / 6
        
        let borderAlpha : CGFloat = 0.3

//ui
        let bottom = UILabel(frame: CGRectMake(0,0,width * 5,200))
        bottom.backgroundColor = UIColor(red:253/255,green:250/255,blue:225/255,alpha:0.8)
        self.view.addSubview(bottom)
        
        calculatorDisplay = UILabel(frame: CGRectMake(10,10,width * 5 - 20,180))
        calculatorDisplay.font = UIFont.systemFontOfSize(40)
        calculatorDisplay.backgroundColor = UIColor.clearColor()
        calculatorDisplay.textAlignment = .Right
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "background")!.drawInRect(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        self.view.addSubview(calculatorDisplay)
        
        let factorial = UIButton(frame: CGRectMake(0,200,width,height))
        factorial.setTitle("!", forState: UIControlState.Normal)
        factorial.backgroundColor = UIColor(red:16/255,green:240/255,blue:197/255,alpha:0.8)
        factorial.layer.borderWidth = 1.0
        factorial.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        factorial.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        factorial.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(factorial)
        
        let square = UIButton(frame: CGRectMake(width,200,width,height))
        square.setTitle("^", forState: UIControlState.Normal)
        square.backgroundColor = UIColor(red:16/255,green:240/255,blue:197/255,alpha:0.8)
        square.layer.borderWidth = 1.0
        square.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        square.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        square.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(square)
        
        let radical = UIButton(frame: CGRectMake(width * 2,200,width,height))
        radical.setTitle("√", forState: UIControlState.Normal)
        radical.backgroundColor = UIColor(red:16/255,green:240/255,blue:197/255,alpha:0.8)
        radical.layer.borderWidth = 1.0
        radical.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        radical.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        radical.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(radical)
        
        let clear = UIButton(frame: CGRectMake(width * 3,200,width * 2,height))
        clear.setTitle("C", forState: UIControlState.Normal)
        clear.backgroundColor = UIColor(red:16/255,green:240/255,blue:197/255,alpha:0.8)
        clear.layer.borderWidth = 1.0
        clear.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        clear.addTarget(self, action: #selector(ViewController.clearTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        clear.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(clear)
        
        let sin = UIButton(frame: CGRectMake(0,200 + height,width,height))
        sin.setTitle("sin", forState: UIControlState.Normal)
        sin.backgroundColor = UIColor(red:16/255,green:235/255,blue:197/255,alpha:0.8)
        sin.layer.borderWidth = 1.0
        sin.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        sin.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        sin.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(sin)
        
        let left = UIButton(frame: CGRectMake(width,200 + height,width,height))
        left.setTitle("(", forState: UIControlState.Normal)
        left.backgroundColor = UIColor(red:16/255,green:235/255,blue:197/255,alpha:0.8)
        left.layer.borderWidth = 1.0
        left.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        left.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        left.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(left)
        
        let right = UIButton(frame: CGRectMake(width * 2,200 + height,width,height))
        right.setTitle(")", forState: UIControlState.Normal)
        right.backgroundColor = UIColor(red:16/255,green:235/255,blue:197/255,alpha:0.8)
        right.layer.borderWidth = 1.0
        right.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        right.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        right.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(right)
        
        let back = UIButton(frame: CGRectMake(width * 3,200 + height,width * 2,height))
        back.setTitle("⬅︎", forState: UIControlState.Normal)
        back.backgroundColor = UIColor(red:16/255,green:235/255,blue:197/255,alpha:0.8)
        back.layer.borderWidth = 1.0
        back.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        back.addTarget(self, action: #selector(ViewController.backspaceTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        back.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(back)
        
        let cos = UIButton(frame: CGRectMake(0,200 + height * 2,width,height))
        cos.setTitle("cos", forState: UIControlState.Normal)
        cos.backgroundColor = UIColor(red:16/255,green:235/255,blue:197/255,alpha:0.8)
        cos.layer.borderWidth = 1.0
        cos.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        cos.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cos.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(cos)
        
        let num7 = UIButton(frame: CGRectMake(width,200 + height * 2,width,height))
        num7.setTitle("7", forState: UIControlState.Normal)
        num7.backgroundColor = UIColor(red:16/255,green:230/255,blue:197/255,alpha:0.8)
        num7.layer.borderWidth = 1.0
        num7.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num7.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num7.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num7)
        
        let num8 = UIButton(frame: CGRectMake(width * 2,200 + height * 2,width,height))
        num8.setTitle("8", forState: UIControlState.Normal)
        num8.backgroundColor = UIColor(red:16/255,green:230/255,blue:197/255,alpha:0.8)
        num8.layer.borderWidth = 1.0
        num8.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num8.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num8.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num8)
        
        let num9 = UIButton(frame: CGRectMake(width * 3,200 + height * 2,width,height))
        num9.setTitle("9", forState: UIControlState.Normal)
        num9.backgroundColor = UIColor(red:16/255,green:230/255,blue:197/255,alpha:0.8)
        num9.layer.borderWidth = 1.0
        num9.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num9.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num9.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num9)
        
        let divide = UIButton(frame: CGRectMake(width * 4,200 + height * 2,width,height))
        divide.setTitle("/", forState: UIControlState.Normal)
        divide.backgroundColor = UIColor(red:16/255,green:230/255,blue:197/255,alpha:0.8)
        divide.layer.borderWidth = 1.0
        divide.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        divide.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        divide.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(divide)
        
        let tan = UIButton(frame: CGRectMake(0,200 + height * 3,width,height))
        tan.setTitle("tan", forState: UIControlState.Normal)
        tan.backgroundColor = UIColor(red:16/255,green:225/255,blue:197/255,alpha:0.8)
        tan.layer.borderWidth = 1.0
        tan.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        tan.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        tan.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(tan)
        
        let num4 = UIButton(frame: CGRectMake(width,200 + height * 3,width,height))
        num4.setTitle("4", forState: UIControlState.Normal)
        num4.backgroundColor = UIColor(red:16/255,green:225/255,blue:197/255,alpha:0.8)
        num4.layer.borderWidth = 1.0
        num4.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num4.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num4.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num4)
        
        let num5 = UIButton(frame: CGRectMake(width * 2,200 + height * 3,width,height))
        num5.setTitle("5", forState: UIControlState.Normal)
        num5.backgroundColor = UIColor(red:16/255,green:225/255,blue:197/255,alpha:0.8)
        num5.layer.borderWidth = 1.0
        num5.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num5.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num5.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num5)
        
        let num6 = UIButton(frame: CGRectMake(width * 3,200 + height * 3,width,height))
        num6.setTitle("6", forState: UIControlState.Normal)
        num6.backgroundColor = UIColor(red:16/255,green:225/255,blue:197/255,alpha:0.8)
        num6.layer.borderWidth = 1.0
        num6.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num6.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num6.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num6)
        
        let multiply = UIButton(frame: CGRectMake(width * 4,200 + height * 3,width,height))
        multiply.setTitle("*", forState: UIControlState.Normal)
        multiply.backgroundColor = UIColor(red:16/255,green:225/255,blue:197/255,alpha:0.8)
        multiply.layer.borderWidth = 1.0
        multiply.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        multiply.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        multiply.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(multiply)
        
        
        
        let log = UIButton(frame: CGRectMake(0,200 + height * 4,width,height))
        log.setTitle("log", forState: UIControlState.Normal)
        log.backgroundColor = UIColor(red:16/255,green:220/255,blue:197/255,alpha:0.8)
        log.layer.borderWidth = 1.0
        log.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        log.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        log.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(log)
        
        let num1 = UIButton(frame: CGRectMake(width,200 + height * 4,width,height))
        num1.setTitle("1", forState: UIControlState.Normal)
        num1.backgroundColor = UIColor(red:16/255,green:220/255,blue:197/255,alpha:0.8)
        num1.layer.borderWidth = 1.0
        num1.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num1.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num1.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num1)
        
        let num2 = UIButton(frame: CGRectMake(width * 2,200 + height * 4,width,height))
        num2.setTitle("2", forState: UIControlState.Normal)
        num2.backgroundColor = UIColor(red:16/255,green:220/255,blue:197/255,alpha:0.8)
        num2.layer.borderWidth = 1.0
        num2.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num2.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num2.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num2)
        
        let num3 = UIButton(frame: CGRectMake(width * 3,200 + height * 4,width,height))
        num3.setTitle("3", forState: UIControlState.Normal)
        num3.backgroundColor = UIColor(red:16/255,green:220/255,blue:197/255,alpha:0.8)
        num3.layer.borderWidth = 1.0
        num3.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num3.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num3.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num3)
        
        let minus = UIButton(frame: CGRectMake(width * 4,200 + height * 4,width,height))
        minus.setTitle("-", forState: UIControlState.Normal)
        minus.backgroundColor = UIColor(red:16/255,green:220/255,blue:197/255,alpha:0.8)
        minus.layer.borderWidth = 1.0
        minus.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        minus.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        minus.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(minus)
        
        let ln = UIButton(frame: CGRectMake(0,200 + height * 5,width,height))
        ln.setTitle("ln", forState: UIControlState.Normal)
        ln.backgroundColor = UIColor(red:16/255,green:215/255,blue:197/255,alpha:0.8)
        ln.layer.borderWidth = 1.0
        ln.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        ln.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        ln.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(ln)
        
        let num0 = UIButton(frame: CGRectMake(width,200 + height * 5,width,height))
        num0.setTitle("0", forState: UIControlState.Normal)
        num0.backgroundColor = UIColor(red:16/255,green:215/255,blue:197/255,alpha:0.8)
        num0.layer.borderWidth = 1.0
        num0.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        num0.addTarget(self, action: #selector(ViewController.numberTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        num0.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(num0)
        
        let dot = UIButton(frame: CGRectMake(width * 2,200 + height * 5,width,height))
        dot.setTitle(".", forState: UIControlState.Normal)
        dot.backgroundColor = UIColor(red:16/255,green:215/255,blue:197/255,alpha:0.8)
        dot.layer.borderWidth = 1.0
        dot.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        dot.addTarget(self, action: #selector(ViewController.dotTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        dot.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(dot)
        
        let equal = UIButton(frame: CGRectMake(width * 3,200 + height * 5,width,height))
        equal.setTitle("=", forState: UIControlState.Normal)
        equal.backgroundColor = UIColor(red:16/255,green:215/255,blue:197/255,alpha:0.8)
        equal.layer.borderWidth = 1.0
        equal.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        equal.addTarget(self, action: #selector(ViewController.equalTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        equal.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(equal)
        
        let plus = UIButton(frame: CGRectMake(width * 4,200 + height * 5,width,height))
        plus.setTitle("+", forState: UIControlState.Normal)
        plus.backgroundColor = UIColor(red:16/255,green:215/255,blue:197/255,alpha:0.8)
        plus.layer.borderWidth = 1.0
        plus.layer.borderColor = UIColor(white: 1.0,alpha: borderAlpha).CGColor
        plus.addTarget(self, action: #selector(ViewController.calculationTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        plus.titleLabel!.font = UIFont.systemFontOfSize(30)
        self.view.addSubview(plus)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
