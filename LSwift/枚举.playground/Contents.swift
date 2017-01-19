
//: ### 枚举
//: 总结挺好 <http://www.jianshu.com/p/1d76b82cee0d>
/*:
 Swift 中的枚举更加灵活，且不需要给枚举中的每一个成员都提供值，如果一个值要被提供给每一个枚举成员，那么这个值可以是字符串、字符、任意的整数值、或者是浮点类型。
 枚举成员可以指定任意类型的值来与不同的成员值关联存储，你可以定义一组相关成员的合集作为枚举的一部分，每一个成员都可以有不同的类型的值的合集与其关联
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

//: 在一个枚举中定义的值，就是枚举的成员值 case 关键字则明确了要定义成员值
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west
print(directionToHead)
directionToHead = .east

directionToHead = .south
switch directionToHead {
case .north :
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

//: #### 关联值
//: 有时将其他类型的关联值与这些成员值一起存储是很有用的。这样就可以将 额外的 自定义 信息和成员值一起存储。
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
//: 定义一个叫做 Barcode的枚举类型，它要么用 (Int, Int, Int, Int)类型的关联值获取 upc 值，要么用 String 类型的关联值获取一个 qrCode的值。
//: 当程序为枚举值指定了关联值之后，程序使用这些枚举值得时候，必须指定它的关联值
var productBarCode = Barcode.upc(8, 85909, 51226, 3)

productBarCode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//: #### 原始值
//: 这有点类似于C和OC中的枚举了, 通过原始值，可以为每个枚举实例指定一个简单类型
enum ASCIICharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
let ascii = ASCIICharacter.tab
print(ascii)

enum WeekDay: Int {
    case Monday = 1, Tuesday, Wednesday, Thursday, Firday, Saturday, Sunday
}

var day = WeekDay.Monday
print(day.rawValue)

//: 字符串类型的枚举值 隐式的原始值与变量名同名
enum Orientation: String {
    case Up, Down, Left = "左", Right
}

//: 可以使用 rawValue 属性来访问一个枚举成员的原始值
let direction = Orientation.Down.rawValue
print(direction)
print(Orientation.Left.rawValue)

//: #### 从原始值初始化
//: 如果你用原始值类型来定义一个枚举，那么就可以通过初始化来返回一个枚举成员或者nil

if let currentDay = WeekDay(rawValue: 5) {
    print(currentDay)
}

//: #### 递归枚举
//: 在有些情况下，枚举值所包含的关联值类型又是该枚举本身，此时就形成了递归枚举

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

// (5 + 4) * 2
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
print(sum)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
print(product)

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))




















