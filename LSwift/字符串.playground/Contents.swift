//: Playground - noun: a place where people can play

import UIKit

//: 字符串初始化
var emptyString = ""
var anotherEmptyString = String()
if emptyString.isEmpty {
    print("Nothing to see here")
}

//: 字符串的可变性
//: 常量字符串不可变，定义为变量则可变

//: 字符串是值类型，在传递给方法或者函数的时候，会被复制过去。赋值给常量或者变量的时候也是一样

for character in "dog!".characters {
    print(character)
}
let exclamationMark: Character = "!"
let catCharacters:[Character] = ["C", "a", "t", "!"]
let catString = String(catCharacters)
print(catString)

//:连接字符串 +、 +=
let string1 = "hello "
let string2 = "there"
var welcome = string1 + string2
var instruction = "look over "
instruction += string2
welcome.append(instruction)

//: 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// multiplier 的值以\(multiplier)的形式插入到了字符串字面量当中，当字符串插值需要备用来创建真的字符串的时候，这个占位符会被 multiplier 的真实值代替

//: 字符统计
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")

//: 字符串索引
//: 不同的字符会获得不同的内存空间来存储，所以为了明确哪个character在哪个特定的位置，你必须从String的开头或结尾遍历每一个Unicode标量。因此，swift的字符串不不能通过整数值索引
let greeting = "Guten Tag!"
greeting.startIndex
greeting[greeting.startIndex]
greeting.endIndex
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]

//: 字符串插入和删除
var hello = "hello"
hello.insert("!", at: hello.endIndex)
hello.insert(contentsOf: "there".characters, at: hello.index(before: hello.endIndex))
hello.remove(at: hello.index(before: hello.endIndex))
let  range = hello.index(hello.endIndex, offsetBy: -6)..<hello.endIndex
hello.removeSubrange(range)

//: 一些Unicode表示方法，目前感觉不知道哪里用，暂时略过。。。
























