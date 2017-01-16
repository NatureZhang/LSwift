//: Playground - noun: a place where people can play

import UIKit

/*:
 -----
 */
//: #### For - in 循环
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

//: _
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
 > 特别之处：Swift中的switch语句不会默认从每个情况的末尾贯穿到下一个情况里。相反，整个switch语句会在匹配到第一个switch情况执行完毕之后退出，不再需要显式的break语句。
 */














































