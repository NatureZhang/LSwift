
//: ### 方法
//: 类、结构体和枚举都能定义实例方法，方法封装了给定类型特定的任务和功能。类、结构体和枚举同样可以定义类型方法，这是与类型本身关联的方法

//: #### 实例方法
//: 实例方法是属于特定类实例、结构体或者枚举实例的函数。实例方法默认可以访问同类型下所有其他实例方法和属性。实例方法只能在类型的具体实例里被调用。
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        self.count = 0
    }
}

let counter = Counter()
print(counter.count)

counter.increment()
print(counter.count)

counter.increment(by: 5)
print(counter.count)

counter.reset()
print(counter.count)

//: 如果没有显示的写出self， swift会在你于方法中使用已知属性或者方法的时候，假定你是调用了当前实例中的属性或者方法。如果一个实例方法的形式参数名与实例中的某个属性重名，那么形式参数名具有优先权

//: #### 在实例方法中修改值类型
/*:
 结构体和枚举是值类型，默认情况下，值类型属性不能被自身的实例方法修改  
 如果需要在特定的方法中修改结构体或者枚举属性，可以选择将这个方法异变。然后就可以在这个方法中改变它的属性了，并且任何改变在方法结束的时候都会写入到原始的结构体中。方法同样可以指定一个全新的实例给它隐含的 self 属性，并且这个新的实例将会在方法结束的时候替换掉现存的这个实例
 */

struct Point {
    
    var x = 0.0, y = 0.0
    mutating func moveByX(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    mutating func moveSelfBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}

var somePoint = Point(x:1.0, y: 1.0)
somePoint.moveByX(x: 2.0, y: 3.0)
print("point (\(somePoint.x), \(somePoint.y))")

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low

ovenLight.next()

ovenLight.next()

//: #### 类型方法
/*:
 类型本身调用的方法（同类方法），通过在func 关键字之前使用 static 关键字来明确一个类型方法。同样可以使用 class 关键字来允许子类重写父类对类型方法的实现。在类型方法中隐含的 self 属性指向类本身  
 一个类型方法可以使用方法名调用另一个类型方法，并不需要使用类型名字作为前缀。
 */
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if  level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }
        else {
            return false
        }
    }
}



























































































