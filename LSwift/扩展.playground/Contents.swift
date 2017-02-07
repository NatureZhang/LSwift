//: ### 扩展
/*:
 扩展为现有的类、结构体、枚举类型、或协议添加了新功能。这也包括了为无访问权限的源代码扩展类型的能力。扩展和Objective-C中的分类类似。（与OC的分类不同的是，swift的扩展没有名字）  
 swift中的扩展可以：  
 * 添加计算实例属性和计算类型属性
 * 定义实例方法和类型方法
 * 提供新初始化器
 * 定义下标
 * 定义和使用新内嵌类型
 * 使现有的类型遵循某协议  
 在swift中，可以扩展一个协议，以提供其要求的实现或添加符合类型的附加功能
 */

/*:
 > 扩展可以向一个类型添加新的方法，但是不能重写已有的方法
 */


//: #### 扩展的语法
/*:
 使用 extension 关键字来声明扩展  
 ```
 extension SomeType {
 // new functionality to add to SomeType goes here
 }
 ```
 
 扩展可以使已有的类型遵循一个或多个协议
 ```
 extension SomeType: SomeProtocol, AnotherProtocol {
 // implementation of protocol requirements goes here
 }
 ```
 */

//: #### 计算属性
//: 扩展可以向已有的类型添加计算实例属性和计算类型属性
extension Double {
    
    var km: Double {
        return self * 1_000.0
    }
    
    var m: Double {
        return self
    }
    
    var cm: Double {
        return self / 100.0
    }
    
    var mm: Double {
        return self / 1_000.0
    }
    
    var ft: Double {
        return self / 3.28084
    }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")

let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

/*:
 > 扩展可以添加新的计算属性，但是不能添加存储属性，也不能向已有的属性添加属性观察者
 */

//: #### 初始化器
/*:
 扩展能为类添加新的便捷初始化器，但是不能为类添加指定初始化器或反初始化器。指定初始化器和反初始化器必须由原来的类提供
 */

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect.init(origin: Point.init(x: 2.0, y: 2.0), size: Size.init(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))

//: #### 方法
//: 扩展可以为已有的类型添加新的实例方法和类方法
extension Int {
    func repetitions(task:() -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions { 
    print("Hello")
}

//: #### 异变实例方法
//: 增加了扩展的实例方法仍可以修改（异变）实例本身。结构体和枚举类型方法在修改 self 或本身的属性时必须标记实例方法为 mutating，和原本实现的异变方法一样
extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 3
someInt.square()

//: #### 下标
//: 扩展能为已有的类型添加新的下标。
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
    }
}

print(746381295[0])
print(746381295[8])
print(746381295[9])

//: #### 内嵌类型
//: 扩展可以为已有的类、结构体和枚举类型添加新的内嵌类型
extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
}

func printIntegerKinds(numbers: [Int]) {
    
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        }
    }
    
    print("")
}

printIntegerKinds(numbers: [3, 19, -27, 0, -6, 0, 7])



































































