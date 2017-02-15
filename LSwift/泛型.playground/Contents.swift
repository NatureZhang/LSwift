
//: ### 泛型
/*:
 泛型代码让你能根据你所定义的要求写出可以用于任何类型的灵活的、可复用的函数。你可以编写出可复用、意图表达清晰、抽象的代码
 */

//: #### 泛型函数
/*:
 泛型版本的函数用了一个占位符类型名，而不是一个实际的类型名。占位符类型名没有声明T必须是什么样的，但是它确实说了 a 和 b 必须都是同一个类型T，或者说都是 T 所表示的类型。（<T>）尖括号告诉swift， T 是一个占位符类型
 */
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}


var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
print("someInt:\(someInt), anotherInt:\(anotherInt)")

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("someString: \(someString), anotherString: \(anotherString)")

//: #### 类型形式参数
//: 占位符类型 T 就是一个类型形式参数的例子，类型形式参数指定并且命名一个占位符类型，紧挨着写在函数名后面的一对尖括号里（比如 <T>）。可以通过在尖括号里写多个用逗号隔开的类型形式参数名，来提供更多类型形式参数

//: #### 泛型类型
//: 除了泛型函数，Swift允许定义自己的泛型类型。它们是可以用于任意类型的自定义类、结构体、枚举，和Array、Dictionary方式类似

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item:Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

let fromTheTop = stackOfStrings.pop()
print(fromTheTop)

//: #### 扩展一个泛型类型
//: 当扩展一个泛型类型时，不需要在扩展的定义中提供类型形式参数列表。原始类型定义的类型形式参数列表在扩展体里仍然有效，并且原始类型形式参数列表名称也用于扩展类型形式参数
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem)")
}

//: #### 类型约束
/*:
 类型约束指出一个类型形式参数必须继承自特定类，或者遵循一个特定的协议、组合协议。  
 在一个类型形式参数名称后面放置一个类或者协议作为形式参数列表的一部分，并用冒号隔开，以写出一个类型约束

 ```
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
     // function body goes here
 }
 ```
 */

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.1, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])

//: #### 关联类型
//: 关联类型给协议中用到的类型一个占位符名称。直到采纳协议时，才指定用于该关联类型的实际类型。关联类型通过 associatedtype 关键字指定

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count:Int { get }
    subscript(i: Int) -> ItemType{ get }
}

/*:
 Container 协议声明了一个叫做 ItemType 的关联类型，写作 associatedtype ItemType 。协议没有定义 ItemType 是什么类型，这个信息留给遵循协议的类型去提供。但是， ItemType 这个别名，提供了一种引用 Container 中元素类型的方式，定义了一种用于 Container 方法和下标的类型，确保了任何 Container 期待的行为都得到满足。  
 typealias ItemType = Int 把 ItemType 抽象类型转换为了具体的 Int 类型
 */

extension Stack: Container {
//    typealias ItemType = <#type#>
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

extension Array: Container {}
//: #### 泛型Where语句
/*:
 类型约束允许你在泛型函数或泛型类型相关的类型形式参数上定义要求。类型约束在为关联类型定义要求时也很有用。通过定义一个泛型 where 语句来实现。泛型 where 语句让你能够要求一个关联类型必须遵循指定的协议，或者指定的类型形式参数和关联类型必须相同。泛型 where 语句以 where 关键字开头，后接关联类型的约束或类型和关联类型一直的关系。泛型 where 语句卸载一个类型或函数体的左半个大括号前面。
 
 */

func allItemsMatch<C1: Container, C2: Container> (_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}


stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
























































