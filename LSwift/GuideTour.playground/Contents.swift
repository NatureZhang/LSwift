//: Playground - noun: a place where people can play

import UIKit

// 常量 字符串
let label = "the width is"
let width = 94
let widthLabel = label + String(width)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

// 数组
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
print(shoppingList[1])
shoppingList[1] = "bottle of water"
print(shoppingList)
let emptyArray = [String]()

// 字典
var occupations = [
    "Nature":"男",
]
print(occupations)
occupations = [:]
let emptyDic = [String : Float]()


////////// 控制流
// 使用if和switch来进行条件操作，使用for in、for、while、repeat-while 进行循环，包裹条件的（）可以省略
let individualScores = [74, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}
print(teamScore)

// if语句 条件必须是一个bool表达式，不能直接用其他值来做判断
var optionalString: String? = "Hello"
print(optionalString == nil)
var optionalName : String? = "John"
var greeting = "Hello!"
if let name = optionalName {
    // 这个地方什么意思呢？没有看懂
    greeting = "Hello, \(name)"
}

// 一种处理可选值的方法是通过 ?? 操作符来提供一个默认值
let nickName : String? = nil
let fullName : String = "John Appleseed"
let infomalGreeting = "Hi \(nickName ?? fullName )"

let interestingNumbers = [
    "Prime":[2, 3, 5, 7, 11, 13],
    "Fibonacci":[1, 1, 2, 3, 5, 8],
    "Square":[1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number;
        }
    }
}
print(largest)

var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2;
} while m < 100
print(m)

var total = 0
// ..< 创建的范围不包含上界，... 创建的范围包含上界
for i in 0...4 {
    total += i
}
print(total)

// 函数和闭包
// 使用func 来声明一个函数，使用名字和参数来调用函数。使用 -> 来指定函数返回值的类型
func greet(person:String, day:String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

// 使用元组来让一个函数返回多个值，该元组的元素可以用名称或数字来表示
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.min)
print(statistics.2)

// 可变个数的参数，这些参数在函数内表现为数组的形式
func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum;
}
sumOf()
sumOf(numbers: 42, 456, 12)
// 函数可以嵌套。被嵌套的函数可以访问外侧函数的变量，可以使用嵌套函数来重构一个太长或者太复杂的函数 (ps: 感觉类似于OC中的block)
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// 函数可以作为一个函数的返回值
let a = 10
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

// 函数可以作为一个函数的参数
func hasAnyMatches(list: [Int], condition:(Int)->Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}

var numbers = [20, 19, 7, 12]
hasAnyMatches(list: numbers, condition: lessThanTen)

// 类

//: 







































