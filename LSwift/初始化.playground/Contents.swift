
//: ### 初始化

/*: 
 > 不同于 OC 的初始化器，swift 初始化器不返回值。这些初始化器主要的作用就是 确保 在第一次使用之前某类型的新实例能够正确初始化。
 */

//: #### 为存储属性设置初始化值
/*:
  在创建类和结构体的实例时必须为所有的存储属性设置一个初始值。存储属性不能在不确定的状态中。可以在初始化器中为存储属性设置一个初始值，或者通过分配一个默认的属性值作为属性定义的一部分。  
 当你给一个存储属性分配默认值，或者在一个初始器里设置它的初始值的时候，属性值被直接设置，不会调用属性监听器
 */

//: #### 初始化器
/*:
   
 init() {
 
 }
 
 */

struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)")

//: #### 自定义初始化
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 237.15
    }
}

let boilingPointOfWater = Celsius.init(fromFahrenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius)

let freezingPointOfWater = Celsius.init(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)

//: 初始化器并不能像函数和方法那样在圆括号前面有一个用来区分的函数名。因此，一个初始化器的参数名称和类型在识别该调用哪个初始化器的时候就扮演了一个重要的角色。因此，如果没有提供外部名Swift会自动为每一个形式参数提供一个外部名称

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color.init(white: 0.5)

//: #### 可选属性类型
//: 在初始化的任意时刻，都可以为常量属性赋值，只要它在初始化结束时设置了确定的值即可
class SurveyQuestion {
    
    let text2: String
    var text: String
    var response: String?
    
    init(text: String, text2: String) {
        self.text = text
        self.text2 = text2
        
    }
    
    func ask() {
        print(text + text2)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?", text2: " haha")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese"

//: #### 默认初始化器
//: Swift 为所有没有提供初始化器的结构体或类提供了一个默认的初始化器来给所有的属性提供默认值。这个默认的初始化器只是简单的创建了一个所有属性都有默认值的新实例
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()

//: #### 结构体类型的成员初始化器
//: 如果结构体类型中没有定义任何自定义初始化器，它会自动获得一个成员初始化器，不同于默认初始化器，结构体会接收成员初始化器，即使它的存储属性没有默认值
struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size.init(width: 2.0, height: 2.0)

//: #### 值类型的初始化器委托
//: 初始化器可以调用其他初始化器来执行部分实例的初始化。这个过程，就是所谓的初始化器委托。对于值类型，当写自己自定义的初始化器时，可以使用 self.init 从相同的值类型里引用其他初始化器，且只能从初始化器里调用 self.init。如果为值类型定义了自定义初始化器，就不能访问那个类型的默认初始化器。这个限制防止别人意外地使用自动初始化器而把复杂初始化器里提供的额外必要配置给覆盖掉的情况发生
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {
    }
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y:originY), size: size)
    }
}

let basicRect = Rect()
print(basicRect)

let originRect = Rect.init(origin: Point.init(x: 2.0, y: 2.0), size: Size.init(width: 10, height: 10))
print(originRect)

let centerRect = Rect.init(center: Point.init(x: 4.0, y: 4.0), size: Size.init(width: 3.0, height: 3.0))
print(centerRect)

//: #### 类的继承和初始化
//: 所有类的存储属性，包括从他的父类继承的所有属性，都必须在初始化期间分配初始值

/*:
 指定初始化器：初始化所有属性初始值  
 init (parameters) {
    statements
 }
 */

/*:
 便利初始化器：可以调用指定初始化器，并提供一些默认值  
 convenience init (parameters) {  
    statements  
 }
 */

/*:
 为了简化 指定和便捷初始化器之间的调用关系，Swift在初始化器之间的委托调用有三条规则
 1. 指定初始化器必须从它的直系父类调用指定初始化器
 2. 便捷初始化器必须从相同的类里调用另一个初始化器
 3. 便捷初始化器最终必须调用一个指定初始化器
 */

//: #### 两段式初始化

/*:
 安全检查：  
 1. 指定初始化器必须保证在向上委托给父类初始化器之前，其所在类引用的所有属性都要初始化完成。一个对象的内存只有在其所有存储型属性确定之后才能完全初始化
 2. 指定初始化器必须向上委托父类初始化器，然后才能为继承的属性设置新值。如果不这样做，指定初始化器赋予的新值将被父类中的初始化器覆盖
 3. 便捷初始化器，必须先委托同类中的其他初始化器，然后再为任意属性赋新值（包括同类里定义的属性）。如果没这么做，便利构造器赋予的新值将被自己类中其他指定初始化器所覆盖
 4. 初始化器在第一阶段初始化完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用self作为值。直到第一阶段结束后才完全合法。属性只能被读取，方法只能被调用，直到第一阶段结束的时候，这个类实例才被看做是合法的。
 */






























































