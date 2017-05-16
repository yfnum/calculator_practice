//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Christiaan Lam on 07-07-16.
//  Copyright © 2017 Air Productions. All rights reserved.
//

import Foundation

class CalculatorBrain{
    // value of the calculation
    fileprivate var accumulator = 0.0
    
    // value coming in
    func setOperand (_ operand: Double){
        accumulator = operand
    }
    
    // operations [constant]
    // what do we need to do?
    // is it a constant or a calculation
    // have class Operation do it
    internal let operations: Dictionary <String, Operation> = [
        "π" : Operation.constant(.pi),
        "e" : Operation.constant(M_E),
        "√" : Operation.symbolCalc(sqrt),
        "cos" : Operation.symbolCalc(cos),
        "×" : Operation.valueCalc({ $0 * $1 }),
        "X²" : Operation.symbolCalc({pow($0,2)}),
        "1/x" : Operation.symbolCalc({1 / $0}),
        "%" : Operation.symbolCalc({$0 / 100}),
        "+" : Operation.valueCalc({ $0 + $1 }),
        "-" : Operation.valueCalc({ $0 - $1 }),
        "÷" : Operation.valueCalc({ $0 / $1 }),
        "±" : Operation.symbolCalc({ -$0 }),
        "=" : Operation.isEqual,
        "C" : Operation.clear
        
    ]
    
    // performOperation [function]
    // value of constants, mathematical calculation
    // in: symbol: String
    func performOperation (_ symbol: String) {
        if let whattodo = operations[symbol]{
            switch whattodo{
            case .constant(let value):
                accumulator = value
            case .isEqual:
                doPendingValueCalculation()
            case .valueCalc(let function):
                doPendingValueCalculation()
                pending = PendingValueCalculation(binaryFunction: function, firstOperand: accumulator)
            case .symbolCalc(let function):
                accumulator = function(accumulator)
            case .clear:
                accumulator = 0
            }
        }
    }
    
    
    private func doPendingValueCalculation(){
        if pending != nil{
        accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
     }
    }
    
    private var pending: PendingValueCalculation?
    
    // PendingValueCalculation [function]
    // takes two Doubles , does mathematical magic, returns a Double
    private struct PendingValueCalculation{
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
        
    }
    
    // Operation [klasse, enum]
    enum Operation{
        case constant(Double)
        case symbolCalc((Double) -> Double)
        case valueCalc((Double, Double) -> Double)
        case isEqual
        case clear
    }
    
    
    // return to sender through brain.result
    var result: Double{
        get {
            return accumulator
        }
    }
}
