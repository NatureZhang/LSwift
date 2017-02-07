//: ### 协议

//: 协议为 方法、属性、以及其他特定的任务需求或功能定义蓝图。协议可被类、结构体、或枚举类型采纳以提供所需功能的具体实现。满足了协议中需求的任意类型都叫做遵循了该协议

//: #### 协议的语法
/*:
 定义协议的方式与类、结构体、枚举类型非常相似
 ```
 protocol SomeProtocol {
     // protocol definition goes here
 }
 ```  
 若一个类拥有父类，将这个父类名放在其采纳的协议名之前，并用逗号分隔
 ```
 class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
     // class definition goes here
 }
 ```
 */

//: #### 属性要求
/*:
 协议可以要求所有遵循该协议的类型提供特定名字和类型的实例属性或类型属性。协议只要求属性有特定的名称和类型。协议同时要求一个属性必须明确是可读的或可读可写的。
 ```
 protocol SomeProtocol {
     var mustBeSettable: Int { get set }
     var doesNotNeedToBeSettable: Int { get }
 }
 ```
 */

protocol FullyNamed {
    // 这个协议只要求遵循者提供一个全名的属性
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person.init(fullName: "John")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " ": "") + name
    }
    
}

var ncc1701 = Starship.init(name: "Enterprise", prefix: "USS")

//: #### 方法要求
/*:
 协议可以要求遵循者实现指定的实例方法和类方法,只定义方法名，不需要方法主体。允许拥有参数，但是不能有默认值
 ```
 protocol SomeProtocol {
     static func someTypeMethod()
 }
 ```
*/

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")

print("And another one: \(generator.random())")

//: #### 异变方法要求












