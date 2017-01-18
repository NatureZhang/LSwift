//: Playground - noun: a place where people can play

import UIKit

/*:
 -----
 */
//: #### For - in 循环
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let base = 3
let power = 10
var answer = 1
for _ in 1 ... power {
    answer *= base;
}
print("\(base) to the power of \(power) is \(answer)")

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("hello \(name)")
}

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}

/*:
 -----
 */
//: #### While 循环
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
var square = 0
var diceRoll = 0
while square < finalSquare {
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
    }
    square += diceRoll
    if square < board.count {
        square += board[square]
    }
}
print("Game over!")

var sum = 0
repeat {
    
    sum += 1
    
} while sum <= 100
print(sum)

/*:
 -----
 */
//: #### if 语句
//: if 与 其他语言中的 if 语句没有什么不同

//: #### Switch
let someCharacter: Character = "Z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")
case "z":
    print("The last letter of the alphabet")
default:
    print("Some other character")
}

//: switch 情况的值可以在一个区间中匹配。
let approximateCount = 62
let countedThings = "moons orbiting saturn"
var naturalCount:String

switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")

/*:
 > 特别之处：Swift中的switch语句不会默认从每个情况的末尾贯穿到下一个情况里。相反，整个switch语句会在匹配到第一个switch情况执行完毕之后退出，不再需要显式的break语句。switch 语句应该是全面覆盖的
 */

//: 可以使用元组来在一个switch语句中测试多个值。每个元组中的元素都可以与不同的值或者区间进行匹配，使用下划线 _ 来表明匹配所有可能的值
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(\(somePoint.1), 0) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//: 值绑定 switch 情况可以将匹配到的值临时绑定为一个常量或者变量，来给情况的函数体使用。
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

//: Where 情况只有where分句情况评定为true时才会匹配这个值
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

//: 复合情况
let character:Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(character) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(character) is a consonant")
default:
    print("\(character) is not a vowel or a consonant")
}

/*:
 ----------
 */
//: #### 转移控制语句

//: continue、break 同其他情况一样
//: Fallthrough: swift 中的 case不会贯穿，使用fallthrough可以实现贯穿
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
case 4, 6, 9:
    description += " test "
default:
    description += " an integer."
}
print(description)

/*:
 > fallthrough 不会检查贯穿入情况的条件，而是使代码执行直接移动到下一个情况的代码块中
 */

//: #### 语句标签
//: 可以给语句打上标签来标记某个语句
var sum2 = 0
addLoop: while sum2 < 100 {
    switch sum2 {
    case 50:
        break addLoop
    default:
        sum2 += 1
    }
}
print("sum2 = \(sum2)")

//: #### 监视语句
//: guard 语句，类似于if语句，使用guard语句来要求一个条件必须是*true*才能执行guard之后的语句, 当条件为 *false*时，才会执行紧跟其后的else语句中。<http://www.jianshu.com/p/3a8e45af7fdd>感觉这个讲的挺好理解
func fooif(x: Int) {
    if x < 0 {
        // 不符合条件的语句
        return
    }
    
    // 使用x
}

func fooGuard (x: Int) {
    guard x > 0 else {
        // 不符合条件的语句
        return
    }
    // 使用x
}


//: #### 检查Api的可用性
if #available(iOS 10, *) {
    
} else {
    
}
