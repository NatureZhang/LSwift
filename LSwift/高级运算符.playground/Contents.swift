
//: ### 高级运算符
/*:
 与C的算数运算符不同，swift中算数运算符默认不会溢出。溢出行为都会作为错误被捕获，要允许溢出行为，可以使用swift中另一套默认支持的溢出运算符，比如溢出加法运算符（&+），所有的这些溢出运算符都是以（&）符号开始  
 Swift允许自定义自己的中缀、前缀、后缀和赋值运算符，以及相应的优先级和结合性。这些运算符可以像预先定义的运算符一样在你的代码里使用和采纳，甚至可以扩展已存在的类型来支持你自定义的运算符
 */

//: #### 位运算符
//: 位运算符在处理外部资源的原始数据时也非常有用，比如为自定义的通信协议的数据进行编码和解码。

//: #### 位取反运算符
//: 位取反运算符（ ~ ）是对所有位的数字进行取反操作
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits

//: #### 位与运算符
//: 位与运算符（ & ）可以对两个数的比特位进行合并。它会返回一个新的数，只有当这两个数都是 1 的时候才能返回 1 。(相同为1)
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits

//: #### 位或运算符
//: 位或运算符（ | ）可以对两个比特位进行比较，然后返回一个新的数，只要两个操作位任意一个为 1 时，那么对应的位数就为 1 （有1则1）
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedBits = someBits | moreBits

//: #### 位异或运算符
//: 位异或运算符，或者说“互斥或”（ ^ ）可以对两个数的比特位进行比较。它返回一个新的数，当两个操作数的对应位不相同时，该数的对应位就为 1 （不同为1，相同为0）
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits

//: #### 位左移和右移运算符
/*:
 位左移（<<）和位右移（>>）可以把所有位数的数字向左或向右移动一个确定的位数。位左和右移具有给整数乘以或除以二的效果。将一个数左移一位相当于把这个数翻倍，将一个数右移一位相当于把这个数减半
 */

//: #### 无符号整数的移位操作
/*:
 1 已经存在的比特位按指定的位数进行左移和右移
 2 任何移动超出整型存储边界的位都会被丢弃
 3 用0来填充向左或向右移动后产生的空白位
 */
let shiftBits: UInt8 = 4
shiftBits << 1
shiftBits << 2
shiftBits << 6
shiftBits >> 2

let pink: UInt32 = 0xcc6699
let redComponent = (pink & 0xff0000) >> 16

//: #### 有符号整型的位移操作
/*:
 有符号整型使用它的第一位来表示这个整数是正数还是负数，符号位为0表示正数，1表示负数，其余位数，存储了实际的值。  
 负数存储的是 2的n次方减去它的绝对值，这里的n为数值位的位数。负数的编码就是所谓的二进制补码表示。  
 对有符号数的右移有一个额外的规则：当对正整数进行位右移操作时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充
 */

//: #### 溢出运算符
/*:
 当向一个整数赋超过它容量的值时，Swift会报错而不是生成一个无效的数. 当故意想使用溢出来截断可用位的数字时，可以选择使用移除运算符
 * 溢出加法 （&+）
 * 溢出减法 （&-）
 * 溢出乘法 （&*）
 对于无符号和有符号整型数值来说，当出现上溢时，它们会从数值所能容纳的最大数变成最小的数。同样的，当发生下溢时，它们会从所能容纳的最小数变成最大的数
 */

var unsignedOverflow = UInt8.max
unsignedOverflow = unsignedOverflow &+ 1

unsignedOverflow = UInt8.min
unsignedOverflow = unsignedOverflow &- 1

var signedOverflow = Int8.min
signedOverflow = signedOverflow &- 1

signedOverflow = Int8.max
signedOverflow = signedOverflow &+ 1

//: #### 优先级和结合性
/*:
 运算符的优先级使得一些运算符优先于其他运算符，高优先级的运算符会先被计算  
 结合性定义了具有相同优先级的运算符是如何结合（或关联）的 —— 是与左边结合为一组，还是与右边结合为一组。可以这样理解：“它们是与左边的表达式结合的”或者“它们是与右边的表达式结合的”。
 */

//: #### 运算符重载
//: 类和结构体可以为现有的运算符提供自定义的实现
struct Vector2D {
    var x = 0.0
    var y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D.init(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector = Vector2D.init(x: 3.0, y: 1.0)
let anotherVector = Vector2D.init(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
print(combinedVector)

//: #### 前缀和后缀运算符
//: 要实现前缀和后缀运算符，需要在声明运算符函数的时候在func 关机字之前指定 prefix 或者 postfix 限定符
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D.init(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D.init(x: 3.0, y: 4.0)
let negative = -positive
print(negative)

//: #### 组合赋值运算符
//: 与赋值运算符（=）与其他运算符进行结合。比如 （+=）
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

var original = Vector2D.init(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D.init(x: 3.0, y: 4.0)
original += vectorToAdd
print(original)

//: 不能对默认的赋值运算符（ = ）进行重载。只有组合赋值运算符可以被重载。同样地，也无法对三元条件运算符 a ? b : c  进行重载.

//: #### 等价运算符
//: 自定义类和结构体不接收等价运算符的默认实现，也就是所谓的 “等于”运算符（==）和“不等于”运算符（！=）。需要自己去实现
extension Vector2D {
    static func == (letf: Vector2D, right: Vector2D) -> Bool {
        return (letf.x == right.x) && (letf.y == right.y)
    }
    
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}

//: #### 自定义运算符
//: Swift还可以声明和实现自定义运算符，新的运算符要在全局作用域内，使用 operator 关键字进行声明，同时还需要指定 prefix、infix 或者 postfix限定符

prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled

print(afterDoubling)

//: #### 自定义中缀运算符的优先级和结合性
/*:
 自定义中缀（infix）运算符也可以指定优先级和结合性。结合性（associativity）可取的值有left，right 和 none。  
 当左结合运算符跟其他相同优先级的左结合运算符写在一起时，会跟左边的操作数进行结合  
 当右结合运算符跟其他相同优先级的右结合运算符写在一起时，会跟右边的操作数进行结合。
 非结合运算符不能跟其他相同优先级的运算符写在一起。  
 associativity 的默认值是 none ， precedence 默认为 100 。
 */

infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
print("plusMinusVector : \(plusMinusVector)")






















































