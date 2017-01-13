//: Playground - noun: a place where people can play

import UIKit

//: 集合的可变性
//: 如果你创建一个数组、集合或者一个字典，并且赋值给一个变量，那么创建的集合就是可变的。如果赋值给一个常量，则集合就是不可变的
/*: 数组
 ------
 */
//: ### 数组
//: #### 创建一个空数组
var someInts = [Int]()
var emptyArr = Array<Int>()
print("someInts is of type [Int] with \(someInts.count) items")
someInts = []

//: #### 使用默认值创建数组
var threeDoubles = Array(repeating:0.0, count:3)
var anotherThreeDouble = Array(repeating: 2.5, count:3)
var sixDoubles = threeDoubles + anotherThreeDouble

//: #### 使用数组字面量创建数组
//var shopingList:[String] = ["eggs", "milk"]
var shoppingList = ["eggs", "milk"]

//: #### 访问和修改数组
if shoppingList.isEmpty {
    print("the shopping list is empty")
} else {
    print("the shopping list is not empty")
}

shoppingList.append("flour")

shoppingList += ["cheese", "butter"]

var firstItem = shoppingList[0]

shoppingList[0] = "Six eggs"

shoppingList[2...4] = ["Bananas", "Apples"]

print(shoppingList)

shoppingList.insert("Maple Syrup", at: 0)

let mapleSyrup = shoppingList.remove(at: 0)

shoppingList.removeFirst()

shoppingList.removeLast()

for item in shoppingList {
    print(item)
}

print(shoppingList.count)

for (index, value) in shoppingList.enumerated() {
    print("item \(index + 1): \(value)")
}

/*: 集合 Set
 ------
 */

//: #### 创建一个空的集合
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items")
letters.insert("a")
letters.count
letters = []

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

//: #### 访问和修改合集
print("I have \(favoriteGenres.count) favorite music genres.")

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences")
}

favoriteGenres.insert("jazz")

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre) ? I'm over it.")
} else {
    print("I never much cared for that")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}

//: #### 遍历集合
for genrc in favoriteGenres {
    print(genrc)
}

for genrc in favoriteGenres.sorted() {
    print(genrc)
}

//: #### 基本集合操作

/*:
 * union 合集
 * intersection 交集
 * subtracting 不包含
 * symmetricDifference 不相同的部分
 */
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumber: Set = [2, 3, 5, 7]
oddDigits.union(evenDigits).sorted()
oddDigits.intersection(evenDigits).sorted()
oddDigits.subtracting(singleDigitPrimeNumber).sorted()
oddDigits.symmetricDifference(singleDigitPrimeNumber).sorted()

//: #### 集合成员关系和相等性
/*:
 * == 是否包含相同的值
 * isSubset 一个合集所有的值是否被某合集包含
 * isSuperset 一个合集是否包含某个集合的所有值
 * isStrictSubset 或者 isStrictSupperset 方法来确定某个合集是否为某一个合集的子集或者超集，但并不相等
 * isDisjoint 判断两个合集是否拥有相同的值
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSubset(of: houseAnimals)
farmAnimals.isDisjoint(with: cityAnimals)

//: #### 创建一个空字典
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]

//: #### 用字典字面量创建字典
//: 键值对，键与值用：号分开，键值对之间用“,”分隔
var airports: [String: String] = ["YYZ":"Toronto Pearson", "DUB":"Dublin"]

//: #### 访问和修改字典
print("The airports dictionary contains \(airports.count) items.")

if airports.isEmpty {
    print("The airports dictionary is empty")
} else {
    print("The airports dictionary is not empty")
}

airports["LHR"] = "London"
print(airports)
airports["LHR"] = "London Heathrow"
print(airports)

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

if let airportName = airports["DUB"] {
    print("The name of the airPorts is \(airportName).")
} else {
    print("That airport is not in the airports dictionary")
}

airports["APL"] = "Apple International"
print(airports)
airports["APL"] = nil;
print(airports)

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue)")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

//: #### 遍历字典
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)
let airportNames = [String](airports.values)



































