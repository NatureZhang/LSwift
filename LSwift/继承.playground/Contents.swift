

//: ### 继承
/*:
 > 在 swift 中，类可以调用和访问属于他们父类的 方法、属性和下标脚本，并且可以重写来修改他们的行为。Swift会通过检查重写定义都有一个与之匹配额父类定义来确保重写是正确的。类也可以向继承的属性添加属性观察器，以便属性值在改变时得到通知。可以添加任何属性监视到属性中，不管它是被定义为存储还是计算属性
 */

//: 任何不从另一个类继承的类都是所谓的基类。 Swift类不会从一个通用基类继承。没有指定特定父类的类都会以基类的形式创建
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()

print("Vehicle: \(someVehicle.description)")

//: #### 子类
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

//: #### 重写

//: 重写 使用 override 关键字

//: 重写方法
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()

//: 可以重写属性的 getter 和 setter 方法，无论最开始继承的属性实现为存储属性还是计算属性。你必须声明重写属性的名字和类型，确保编译器

/*:
 > 可以通过在子类重写里为继承而来的只读属性添加Getter和Setter来把他用作可读写属性。但是，不能把一个继承而来的读写属性表示为只读属性。如果提供了一个setter作为属性重写的一部分，你也必须为重写提供一个Getter。如果不想在重写的Getter时修改属性的值，那么可以通过 super.someProperty 来传递继承的值
 */

class Car: Vehicle {
    var gear = 1
    override var description: String{
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 25
car.gear = 3
print("Car： \(car.description)")

//: 重写属性 观察器
/*:
 > 不能给继承而来的常量存储属性或者只读的计算属性添加属性观察器。也不能为同一个属性同时提供重写的setter和重写的属性观察器。如果想要监听属性的变化，并且已经为那个属性提供了一个自定义的setter，那么从自定义的setter里就可以监听任意值的改变
 */
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

//: #### 阻止重写
/*: 
 > 可以通过标记为终点来阻止一个方法、属性、或者下标脚本被重写。是用 final 关键字。任何在子类里重写终点方法、属性、或者下标脚本的尝试都会被报告为编译时错误。在扩展中添加到类的方法、属性或下标脚本也可以在扩展的定义里标记为终点。可以在类定义的 class 关机字前面写 final 修饰为类的终点。
 */













































































