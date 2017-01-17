//: Playground - noun: a place where people can play

import UIKit

/*:
 > Swift 中的每一个函数都有类型，由函数的形式参数类型和返回类型组成。可以像swift中其他类型那样来使用它，这使得你能够方便的讲一个函数当作一个形式参数传递到另一个函数中，也可以在一个函数中返回另一个函数。（就是：函数可以作为参数，也可以作为返回值）。函数同时也可以写在其他函数内部来在内嵌范围封装有用的功能
 */
//: #### 定义和调用函数
//: 可以将“ -> ” 理解为 “函数执行过程” 这个过程执行完成 从而得到一个结果（返回值）
func greet(person: String) -> String {
    let greeting = "Hello," + person + "!"
    return greeting
}
func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}

//: #### 函数的参数和返回值
//: ##### 无参

func sayHelloWorld() -> String {
    return "Hello, world"
}
sayHelloWorld()

//: ##### 多参
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    }
    else {
        return greet(person: person)
    }
}

//: ##### 无返回值
func greet(person: String) {
    print("Hello, \(person)")
}

//: ##### 多返回值的函数
//: 可以使用元组类型作为返回类型, 元组的成员值不必在函数返回元组的时候命名，因为他们的名字已经在函数的返回类型部分被明确
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }
        else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")

//: ##### 可选元组返回类型
//: 如果元组在函数的返回类型中有可能“没有值”，可以用一个*可选元组*返回类型来说明整个元组的可能是nil
func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }
        else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax2(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
/*:
 ------
 */
//: #### 函数实际参数标签和形式参数名
//: 每一个函数的形式参数都包含时间参数标签和形式参数名。实际参数标签 用在调用函数的时候；在调用函数的时候，每一个实际参数前边都要写实际参数标签，形式参数名用在函数的实现当中。 默认情况下，形式参数使用它们的形式参数名作为实际参数标签
//: ##### 指定实际参数标签
//: 在提供形式参数名之前写实际参数标签，用空格分隔
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)."
}
print(greet(person: "zhangdong", from: "China"))

//: ##### 省略实际参数标签
//: 就是在调用的时候会没有参数名
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    
}
someFunction(1, secondParameterName: 2)

//: ##### 默认形式参数值
//: 可以通过在形式参数类型后给形式参数赋一个值来给函数的任意形式参数定义一个默认值，如果定义了默认值，就可以在调用函数时候省略这个形式参数
func someFunction(parameterWithDefault: Int = 12) {
    print("parameter is \(parameterWithDefault)")
}
someFunction(parameterWithDefault: 6)
someFunction()

//: ##### 可变形式参数
//: 输入的形式参数的个数是可变的，在形式参数的类型名称后边插入三个点符号（...）来书写可变形式参数。传入到可变参数中的值在函数的主体中被当作是对应类型的数组。一个函数最多一个可变形式的参数
func arithmeticMean(numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(numbers: 1, 2, 3, 4, 5)

//: ##### 输入输出形式参数
//: 在函数调用时传递的参数都是值传递，函数内部的改变，不会引起外部值的改变。如果想函数能够修改一个形式参数的值，且想这些改变在函数结束之后依然生效，那么需要将形式参数定义为 输入输出 形式参数。在形式参数前添加一个inout关键字即可。调用时，用&符号
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/*:
 ------
 */
//: #### 函数类型
//: 每一个函数都有一个特定的函数类型，它由形式参数类型，返回类型组成。与其他类型同等对待
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//: 这两个函数的类型都是 (Int, Int) -> Int "有两个形式参数的函数类型，它们都是Int类型，并且返回一个Int类型的值"

//: ##### 使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")

//: ##### 函数类型作为形式参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

//: #### 函数类型作为返回类型
//: 就是函数可以作为返回值
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backwards: currentValue > 0)
print("Counting to zero:")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}

//: #### 内嵌函数
//: 在函数的内部定义另外一个函数。内嵌函数在默认情况下在外部是被隐藏起来的，但却仍然可以通过包含它们的函数来调用它们。包裹的函数也可以返回它内部的一个内嵌函数
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    return backward ? stepBackward : stepForward
}








