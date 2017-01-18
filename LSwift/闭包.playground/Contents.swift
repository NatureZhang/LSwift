//: Playground - noun: a place where people can play

import UIKit
/*:
 > 闭包能够捕获和存储定义在其上下文中的任何常量和变量的引用，这也就是所谓的闭合并包裹那些常量和变量
 */
/*:
 * 全局函数是一个有名字但不会捕获任何值得闭包
 * 内嵌函数是一个有名字且能从其上层函数捕获值得闭包
 * 闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或变量值得没有名字的闭包。
 */

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)

/*:
 ---
 */
//: #### 闭包语法
/*:
 > 闭包表达式语法  
 { (parameters) -> (return type) in
 statements
 }  
 闭包的函数整体部分由关键字 _in_ 导入，这个关键字表示闭包的形式参数类型和返回类型定义已经完成，并且闭包的函数体即将开始
 */
/*:
 闭包表达式语法能够使用常量形式参数、变量形式参数和输入输出形式参数，但不能提供默认值。可变形式参数也能使用，但需要在形式参数列表的最后面使用。元组也可被用来作为形式参数和返回类型
 */

reversedNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 > s2
})

//: 因排序闭包为实际参数来传递给函数， 故swift能推断它的形式参数类型和返回类型。
reversedNames = names.sorted(by: {s1, s2 in return s1 > s2})

//: 单表达式闭包能够通过从它们的声明中删掉return关键字来隐式返回它们单个表达式的结果
reversedNames = names.sorted(by: {s1, s2 in s1 > s2})

/*:
 Swift 自动对行内闭包提供简写实际参数名，可以通过 $0, $1, $2 等名字来引用闭包的实际参数值
 如果在闭包表达式中使用这些简写的实际参数名，那么就可以在闭包的实际参数列表中忽略对其的定义，并且简写实际参数名的数字和类型将会从期望的函数类型中推断出来。in 关键字也能被省略，因为闭包表达式完全由它的函数体组成
 */

reversedNames = names.sorted(by: {$0 > $1})

/*:
 Swift 的 String 类型定义了关于 大于号（>）的特定字符串实现，让其作为一个有两个String类型形式参数的函数并返回一个bool 类型的值
 */
reversedNames = names.sorted(by: >)


/*:
 ------
 */
//: #### 尾随闭包
//: 如果需要将一个很长的闭包表达式作为函数最后一个实际参数传递给函数，使用尾随闭包将增强函数的可读性。尾随闭包是一个被书写在函数形式参数的括号外面的闭包表达式
func someFunctionThatTakesAClosure(closure:() -> Void) {
    
}

// 非尾随闭包的调用形式
someFunctionThatTakesAClosure (closure: {
    
})

// 尾随闭包形式的调用
someFunctionThatTakesAClosure {
    
}

reversedNames = names.sorted() { $0 > $1 }
reversedNames = names.sorted { $0 > $1 }

//: #### 捕获值
/*:
 > 一个闭包能够从上下文捕获已被定义的常量和变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍能够在其函数体内引用和修改这些值  
 在swift中，一个能够捕获值的闭包最简单的模型是内嵌函数，即被书写在另一个函数的内部。一个内嵌函数能够捕获外部函数的实际参数并且能够捕获任何在外部函数的内部定义了的常量和变量
 */

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

/*:
 > 作为一种优化，如果一个值没有改变或者在闭包的外面，Swift 可能会使用这个值的拷贝而不是捕获  
 Swift 也处理了变量的内存管理操作，当变量不在需要时会被释放  
   
 如果分配了一个闭包给类实例的属性，并且闭包通过引用改实例或者他的成员来捕获实例，将在闭包和实例间建立一个强引用循环，swift将使用捕获列表来打破这种强引用循环
 */

let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
incrementBySeven()

incrementByTen()

/*:
 > 传递闭包到函数中的时候，系统会默认为 非逃逸闭包类型。当然还有 逃逸闭包类型
 */

/*:
 非逃逸闭包的生命周期：
 1. 把闭包作为参数传递给函数
 2. 函数中运行改闭包
 3. 退出函数
 非逃逸闭包被限制在函数内，当函数退出的时候，该闭包引用计数不会增加，也就是说其引用计数在进入函数和退出函数时保持不变
 */

/*:
 逃逸闭包的生命周期：
 逃逸闭包与非逃逸闭包相反，其生命周期长于相关函数，当函数退出的时候，逃逸闭包的引用仍然被其他对象持有，不会在相关函数结束后释放
 */

/*:
 > 要谨慎使用 @escaping（逃逸闭包），除非明确知道要使用它做什么。
 1. 异步调用：如果需要调度队列中异步调用闭包，这个队列会持有闭包的引用，至于什么时候调用闭包，或闭包什么时候运行结束都是不可预知的。
 2. 存储：需要存储闭包作为属性，全局变量或其他类型做稍后使用
 */

//: 关于逃逸和非逃逸闭包 <http://www.jianshu.com/p/6c6ab0f67308>

//: #### 自动闭包
//: 当把一个闭包作为参数传递的时候，这个闭包有一对醒目的花括号来表示它是个闭包。 自动闭包允许延迟处理，因此闭包内部的代码直到调用它的时候才会运行（延迟求值）。
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving \(customerProvider())!")
print(customersInLine.count)


