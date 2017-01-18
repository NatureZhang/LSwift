
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

var productBarCode = Barcode.upc(8, 85909, 51226, 3)

productBarCode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarCode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}














