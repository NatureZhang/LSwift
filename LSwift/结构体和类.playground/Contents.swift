
/*:
 > Swift 不需要为自定义的类和结构体创建独立的接口和实现文件。在swift中，在一个文件中定义一个类或者结构体，则系统将会自动生成面向其他代码的外部接口
 */

//: #### 对比类与结构体
//: ##### 相同点
/*:
 * 定义属性用来存储值
 * 定义方法用来提供功能
 * 定义下标脚本用来允许使用下标语法访问值
 * 定义初始化器用于初始化状态
 * 可以被扩展来扩展他们功能函数的默认实现 
 * 遵守协议来提供一种特定的标准功能
 */

//: ##### 不同点
/*:
 * 类可以通过继承来继承其他类的特点
 * 类型转换允许你在运行时检查和解释类实例的类型
 * 反初始化器允许类实例释放任何分配给它的资源
 * 引用计数允许不止一个对类实例的引用
 * 结构体在传递过程中是通过拷贝而不是引用计数
 */

class SomeClass {
    
}

struct SomeStructure {
    
}

//: 类名和结构体名，用开头大写的驼峰命名法，属性和方法名用开头小写的驼峰命名法

struct Resolution {
    var width = 0;
    var height = 0;
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//: 实例化结构体和类
let someResolution = Resolution()
let someVideoMode = VideoMode()

//: 用 点语法 访问属性
print("The width of someResolution is \(someResolution.width)")
print("Tht width of someVideo is \(someVideoMode.resolution.width)")

//: 用 点语法 为属性赋值
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

//: 结构体类型的初始化
let vga = Resolution(width: 320, height: 480)
print(vga)

//: #### 结构体和枚举是值类型
/*:
 > 值类型是一种当它被指定到常量或者变量，或者被传递给函数时会被拷贝的类型。实际上，swift中的所有的基本类型（整数，浮点数，布尔量，字符串，数组和字典）都是值类型，并且都已结构的形式在后台实现
 */

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
print(hd.width)
print(cinema.width)

cinema.width = 2048
print(hd.width)
print(cinema.width)

//: #### 类是引用类型
/*: 
 > 不同于值类型，在引用类型被赋值到一个常量、变量、或者本身被传递到一个函数的时候它是不会被拷贝的，相对于拷贝，这里使用的是一个对现存实例的引用
 */

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

print(tenEighty.frameRate)

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print(tenEighty.frameRate)
print(alsoTenEighty.frameRate)

//: #### 特征运算符
//: 如果要判断两个常量或者变量是否引用自同一个实例，可以使用特征运算符。 相同于（===），不同于（!==）
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance")
}

/*:
 * “相同于” 意味着两个类类型 常量或者变量 引用自相同的实例
 * “等于” 意味着两个实例在值上被视作 “相等” 或者 “等价”
 */

/*:
 > Swift 的String，Array和Dictionary类型是作为结构体来实现的，这意味着 字符串、数组、字典在它们被赋值到一个新的常量或者变量，亦或者它们本身被传递到一个函数或者方法的时候，其实是传递的拷贝
 */






































