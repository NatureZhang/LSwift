
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

//: ##### 两段初始化过程 阶段 1
/*:
 * 指定或便捷初始化器在类中被调用
 * 为这个类的新实例分配内存，内存还没有被初始化
 * 这个类的指定初始化器确保所有由此类引入的存储属性都有一个值，现在这些存储属性的内存被初始化了
 * 指定初始化器上交分类的初始化器为其存储属性执行相同的任务
 * 这个调用父类初始化器的过程将沿着初始化器链一直向上执行，直到到达初始化器链的最顶部
 * 一旦到达了初始化器链的最顶部，在链顶部的类确保所有的存储属性都有一个值，此实例的内存被认为完全初始化了，阶段一完成
 */

//: ##### 两段初始化过程 阶段 2
/*:
 * 从顶部初始化器往下，链中的每一个指定初始化器都有机会进一步定制实例。初始化器现在能够访问self并且可以修改它的属性，调用它的实例方法等等
 * 最终，链中任何便捷初始化器都有机会定制实例以及使用self
 */

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle:Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

//: #### 指定和便利初始化器的操作
class Food {
    var name: String
    
    // 指定初始化器
    init(name: String) {
        self.name = name
    }
    
    // 便利初始化器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food.init(name: "Bacon")
let mysteryMeat = Food()

//: 调味类
class RecipeIngredient: Food {
    var quantity : Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient.init(name: "Eggs", quantity: 6)

class ShoppingItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? "✅" : "❎"
        return output
    }
}

//: 由于ShoppingItem为自己引入的所有属性提供了一个默认值并且自己没有定义任何初始化器，ShoppingItem会自动从父类继承所有的指定和便利初始化器
var breakfastList = [
    ShoppingItem(),
    ShoppingItem(name: "Bacon"),
    ShoppingItem(name: "Eggs", quantity: 6),
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}

//: #### 可失败的初始化器
/*:
 定义类、结构体或枚举初始化时，可能出现失败的情况，包括初始化传入无效的形式参数值，或缺少某种外部所需的资源，又或是其他阻止初始化的情况。因此可以定义一些可失败的初始化器。通过 init？  
 可失败的初始化器创建了一个初始化类型的可选值。失败时通过 return nil 语句返回。成功时不用存在return语句
 */

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        
        self.species = species
    }
}

let someCreature = Animal.init(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal wos initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal.init(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//: #### 枚举的可失败初始化器
//: 可以使用一个可失败初始化器来在带一个或多个形式参数的枚举中选择合适的情况。如果提供的形式参数没有匹配合适的情况，初始化器就可能失败

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit.init(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit.init(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//: #### 带有原始值枚举的可失败初始化器
//: 带有原始值的枚举会自动获得一个可失败初始化器 init？(rawValue:), 该可失败初始化器接收一个名为rawValue的合适的原始值类型形式参数，如果没有找到，就触发失败
enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let fahrenheitUnit2 = TemperatureUnit2.init(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded")
}

let unknownUnit2 = TemperatureUnit2.init(rawValue: "X")
if unknownUnit2 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

//: #### 初始化失败的传递
//: 类、结构体或枚举的可失败初始化器可以横向委托到同一个类、结构体或枚举里的另一个可失败初始化器。类似的子类的可失败初始化器可以向上委托到父类的可失败初始化器。无论哪种情况导致了失败，那么整个初始化过程也会立即失败，并且之后任何初始化代码都不会执行。可失败初始化器也可以委托其他的非可失败初始化器。

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CartItem.init(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}


if let zeroShirts = CartItem.init(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem.init(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}

//: 重写可失败初始化器
/*:
 可以重写父类的可失败初始化器，也可以用子类的非可失败初始化器来重写父类可失败初始化器，但是反过来是不行的
 */
class Document {
    var name: String?
    init() {
    }
    init?(name: String) {
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "Untitled")!
    }
}

//: #### 必要初始化器
//: 在类的初始化器前添加 required 修饰符来表明所有该类的子类都必须实现该初始化器
class SomeClass {
    required init() {
        
    }
}

//: 当子类重写父类额必要初始化器时，必须在子类的初始化器前同样添加 required 修饰符以确保当其他类集成该子类时，该初始化器同为必要初始化器。重写时不需要添加 override
class SomeSubClass: SomeClass {
    required init() {
    }
}


//: #### 通过闭包和函数来设置属性的默认值
/*:
 如果某个存储属性的默认值需要自定义或设置，那么可以使用闭包或全局函数来为属性提供默认值。当这个属性属于的实例初始化时，闭包或函数就会被调用，并且它的返回值就会作为属性的默认值  
 注意：闭包花括号的结尾跟一个没有参数的圆括号。这是告诉swift立即执行闭包。如果忽略了这对圆括号，就会把闭包作为值赋给了属性，并且不会返回闭包的值  
 如果使用了闭包来初始化属性，记住闭包执行的时候，实例的其他部分还没有被初始化，这就意味着你不能再闭包里读取任何其他的属性值，即使这些属性有默认值
 */

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
















