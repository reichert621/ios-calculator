//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Alex Reichert on 6/3/17.
//  Copyright © 2017 Alex Reichert. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0

    func setOperand(operand: Double) {
        accumulator = operand
    }

    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }

    private struct PendingBinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }

    private var pending: PendingBinaryOperation?

    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "±": Operation.UnaryOperation({ -$0 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "=": Operation.Equals
    ]

    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let val):
                accumulator = val
            case .UnaryOperation(let op):
                accumulator = op(accumulator)
            case .BinaryOperation(let op):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation(binaryFunction: op, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }

    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }

    var result: Double {
        get {
            return accumulator
        }
    }
}