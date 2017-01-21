
//: #### 属性
//: 属性可以将值与特定的类、结构体、或者枚举联系起来。存储属性将会存储常量或者变量作为实例的一部分，反之计算属性会计算值。计算属性可以由类、结构体和枚举定义。存储属性只能由类和结构体定义

//: ##### 存储属性
//: 在其最简单的形式下，存储属性是一个作为特定类和结构体实例一部分的常量或变量。存储属性要么是变量存储属性，要么是常量存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//: 如果创建了一个结构体的实例并且把这个实例赋值给常量，你不能修改这个实例的属性，即使是声明为变量的属性

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 4 //error

//: 延迟存储属性的初始值再起第一次使用时才进行计算，可以在其声明前标注 lazy 修饰语来表示延迟存储属性(非线程安全的)

class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

//: 因为importer属性被 lazy 修饰符所标记，只有在 importer 属性第一次被访问时才会创建 DataManager 实例，比如当查询它的 fileName 属性时
print(manager.importer.fileName)

/*:
 > Swift 属性没哟与之相对应的实例变量，并且属性的后备存储不能被直接访问。这避免了不同环境中对值的访问的混淆并且将属性的声明简化为一条单一的、限定的语句。所有关于属性的信息--包括他的名字，类型和内存管理特征--都作为类的定义放在了同一个地方
 */

//: #### 计算属性
//: 实际并不存储值，他们提供一个读取器和一个可选的设置器来间接得到和设置其他的属性和值

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0
    var height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
//        set(newCenter) {
//            origin.x = newCenter.x - (size.width / 2)
//            origin.y = newCenter.y - (size.height / 2)
//        }
//        
// 如果一个计算属性的设置器没有为将要设置的值定义一个名字，那么他将被默认命名为 newValue
        set {

            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let squareCenter = square.center
print(squareCenter)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//: 只读属性，一个有读取器，但是没有设置器的计算属性就是所谓的只读就算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume : Double {
        return width * height * depth
    }
}

let fourByFiveTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("The volume of fourByFiveTwo is \(fourByFiveTwo.volume)")

//: #### 属性观察者
//: 属性观察者会观察并对属性值的变化做出回应。每当一个属性的值被设置时，属性观察者都会被调用，即使这个值与该属性当前的值不同
/*:
 * willSet 会在该值被存储之前被调用
 * didSet 会在一个新值被存储后被调用
 */

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
}


let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360

stepCounter.totalSteps = 896

//: willSet 和 didSet 观察者会在每次属性被赋新值的时候调用。

//: #### 类型属性
/*:
 实例属性，是属于实例的。不同的实例可以拥有不同的属性值  
 类型属性，是属于类型的。无论创建多少个类对应的实例，这个属性只有一个  
 使用 static 关键字来开一类型属性。对于类类型的计算属性，可以使用 class 关键字来允许重写父类实现
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableCopmutedTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value"
print(SomeStructure.storedTypeProperty)

print(SomeEnumeration.computedTypeProperty)

print(SomeClass.computedTypeProperty)






























