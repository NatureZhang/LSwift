
import Foundation

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
/*:
 有时候一个方法需要改变其所属的实例，在方法的 func 关键字之前使用 mutating 关键字，来表示在该方法可以改变其所属的实例，以及该实例的所有属性。  
 如果在协议中标记实例方法需求为 mutating，在为类 实现该方法的时候不需要写 mutatiing 关键字。mutating 关键字只在结构体和枚举类型中需要书写
 ```
 protocol Togglable {
     mutating func toggle()
 }
 ```
 */

protocol Togglabel {
    mutating func toggle()
}

enum OnOffSwitch: Togglabel {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}
var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()


//: #### 将协议作为类型
/*:
 协议自身并不实现功能，不过创建的任意协议都可以变为一个功能完备的类型在代码中使用。由于它是一个类型，可以在很多其他类型可以使用的地方使用协议  
 * 在函数、方法或初始化器里作为形式参数类型或者返回类型
 * 作为常量、变量或者属性的类型
 * 作为数组、字典或者其他存储器的元素的类型
 */

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice.init(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

//: 委托
/*:
 概念上跟OC中的委托是一样的。委托是一个允许类或者结构体委托它们自身的某些责任给另外类型实例的设计模式。
 */
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice.init(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        
        print("The game is using a \(game.dice.sides)-side dice")
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

//: #### 在扩展里添加协议遵循
/*:
 可以扩展一个已经存在的类型来采纳和遵循一个新的协议。扩展可以添加新的属性、方法和下标到已经存在的类型，并且允许添加协议需要的任何方法。  
 如果一个类型已经实现了协议的方法，但是还没有声明采纳了这个协议，可以声明一个空的扩展来采纳这个协议
 */
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)


struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable{}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

//: #### 协议类型的集合
//: 协议可以用作存储在集合比如数组或者字典中的类型
let things: [TextRepresentable] = [ d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
}

//: #### 协议继承
/*:
 协议可以继承一个或者多个其他协议并且可以在它继承的基础之上添加更多要求。协议继承的语法与类继承的语法相似，只不过可以选择列出多个继承的协议，用逗号分隔
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
     // protocol definition goes here
 }
 */

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

//: #### 类专用的协议
/*:
 通过添加 class 关键字到协议的继承列表，就可以限制协议只能被类类型采纳。class 关键字必须出现在协议继承列表的最前边，在任何继承的协议之前

 protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
     // class-only protocol definition goes here
 }
 */

//: #### 协议组合
/*:
 要求一个类型一次遵循多个协议是很有用的。可以使用协议组合来复合多个协议到一个要求里。协议组合使用 SomeProtocol & AnotherProtocol 的格式。可以使用 & 符列举任意数量的协议
 */

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person2: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person2.init(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

//: #### 协议遵循的检查
/*:
 可以使用 is 和 as 运算符来检查协议遵循，还能转换为特定的协议。检查 和 转换协议的语法与检查和转换类型是完全一样的
 * 如果实例遵循了协议，is 运算符返回true， 否则返回 false
 * as? 版本的向下转换运算符返回协议的可选项，如果实例不遵循这个协议的话值就是 nil
 * as! 版本的向下转换运算符强制转换协议类型并且在失败时触发运行时错误
 */
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects:[AnyObject] = [Circle.init(radius: 2.0), Country.init(area: 256), Animal.init(legs: 4)]

for object in objects {
    
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    }
    else {
        print("Something that doesn't have an area")
    }
}

//: #### 可选协议要求
/*: 
 可以给协议定义可选要求，这些要求不需要强制遵循协议的类型实现。可选要求使用 optional 修饰符作为前缀放在协议的定义中。可选要求允许你的代码与 Objective-C操作。协议和可选要求必须使用 @objc 标志标记。注意 @objc 协议只能被继承自 Objective-C类或其他 @objc 类采纳，他们不能被结构体或者枚举采纳  
 当在可选要求中使用方法或属性时，它的类型自动变成可选项。
 */
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }
        else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    var fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        }
        else if count < 0 {
            return 1
        }
        else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

//: #### 协议扩展
/*:
 协议可以通过扩展来提供方法和属性的实现，这允许你去定义协议自身的行为，而不是让遵循者或者全局函数里定义。  
 通过给协议创建扩展，所有的遵循类型自动获得这个方法的实现而不需要任何额外的修改
 */

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")
print("And here's a random Boolean: \(generator2.randomBool())")

//: #### 提供默认实现
//: 可以使用协议扩展来给协议的任意方法或者计算属性提供默认实现。如果遵循协议的类提供了他自己的实现，那么它就会替代扩展中提供的默认实现
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//: #### 给协议扩展添加限制
/*:
 可以使用 where 分句来限制协议扩展，只需要在扩展协议名字后边使用 where 分句来写这些限制
 */
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)



