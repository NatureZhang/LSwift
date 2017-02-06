//: #### ARC 的工作机制
/*: ARC的工作机制
 每次创建一个类的实例，ARC会分配一大块内存来存储这个实例的信息。这些内存中保留有实例的类型信息，以及该实例所有存储属性值的信息。  
 当实例不需要时，ARC会释放该实例所占用的内存，释放的内存用于其他用途，这确保类实例当它不在需要时，不会一直占用内存  
 如果ARC释放了正在使用的实例内存，那么它将不会访问实例属性，或者调用实例方法。如果试图访问该实例，app可能会崩溃  
 为了确保使用中的实例不会消失，ARC会跟踪和计算当前实例被多少属性，常量和变量所引用。只要存在对该类实例的引用，ARC将不会释放该实例  
 为了是这些成为可能，无论你将实例分配给属性、变量或常量，他们都会创建该实例的强引用。之所以成为“强”引用，是因为它会将实例保持住，只要强引用还在，实例是不允许被销毁的
 */

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person.init(name: "John Appleseed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
reference3 = nil

//: #### 解决实例之间的循环强引用

/*:
 通过 弱引用（weak）和无主引用（unowned）来解决循环强引用  
 弱引用和无主引用允许循环引用中的一个实例引用另一个实例而不保持强引用  
 对于生命周期中会变成nil的实例使用弱引用。对于初始化赋值后再也不会被赋值为nil的实例，使用无主引用
 */

//: #### 弱引用
/*:
 声明属性和变量时，在前面加上 weak 关键字表明这是一个弱引用  
 ARC会在被应用的实例被释放时，自动设置弱引用为nil。由于弱引用需要允许它们的值为nil，它们一定要是可选类型  
 ARC在给弱引用设置nil时不会调用属性观察者
 */

//: #### 无主引用
/*: 
 和弱引用类似，无主引用不会牢牢保持住引用的实例。无主引用假定是永远有值的。因此，无主引用总是被定义为 非可选类型。在声明变量或属性时在前面加上关键字 unowned 表示这是一个无主引用  
 由于无主引用是非可选类型，不需要在使用它的时候将它展开。无主引用总是可以直接访问。不过ARC无法在实例被释放后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil
 */

/*:
 > 如果试图访问实例的释放了的无主引用，那么会触发运行时错误，只有在确保引用会一直引用实例的时候才使用无主引用。 如果试图访问引用的实例已经被释放了的无主引用，swift会确保程序直接crash。因此不会遭遇无法预期的行为
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("card #\(number) is being deinitialized")
    }
}

var john: Customer?
john = Customer.init(name: "John")
john!.card = CreditCard.init(number: 1234_5678_9012_3456, customer: john!)

john = nil

/*:
 > 上面的例子是 安全的无主引用。还有 不安全的无主引用 unowned(unsafe) 来明确使用一个不安全无主引用。如果在实例的引用被释放后访问这个不安全无主引用，你的程序就会尝试访问这个实例曾经存在过的内存地址
 */

//: #### 无主引用和隐式展开的可选属性
/*:
 1 两个属性的值都允许为nil，用weak
 2 一个属性值允许为nil，而另一个属性的值不允许为nil，用无主引用
 3 两个属性都必须有值，并且初始化完成后永远不会为nil：一个类使用无主引用，另一个类使用隐式展开的可选型
 */
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City.init(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country.init(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

//: #### 闭包循环强引用
/*:
 循环强引用还会出现在你把一个闭包分配给类实例属性的时候，并且这个闭包中又捕获了这个实例。捕获可能发生于这个闭包函数体中访问了实例的某个属性。比如 self.someProperty, 或者这个闭包调用了一个实例方法，例如 self.someMethod()。这两种情况都导致了闭包“捕获”了self，从而产生循环强引用
 */

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
       
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement.init(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement.init(name: "p", text: "hello, world")
print(paragraph!.asHTML())

paragraph = nil //没有打印deinit中的信息

//: #### 解决闭包的循环强引用
/*:
 可以定义 捕获列表 作为闭包的定义来解决在闭包和类实例之间的循环强引用。捕获列表定义了当在闭包体里捕获一个或多个引用类型的规则。正如在两个类实例之间的循环强引用，声明每个捕获的引用为引用或无主引用而不是强引用。应该根据代码关系来决定使用弱引用还是无主引用
 */

//: #### 定义捕获列表

/*:
 捕获列表中的每一项都由 weak 或 unowned 关键字与类实例的引用（如self）或初始化过的变量（如：delegate = self.delegate！）成对组成，这些对写在方括号中用逗号分开
 */


//: #### 弱引用和无主引用
/*:
 在闭包和捕获的实例总是互相引用并且总是同时释放时，将闭包内的捕获定义为无主引用。在被捕获的引用可能变为nil时，定义一个弱引用的捕获。弱引用总是可选项，当实例的引用释放时会自动变为nil。这使我们可以在闭包体内检查它们是否存在。
 */

class HTMLElement2 {
    let name: String
    let text: String?
    
    lazy var asHTML: (Void) -> String = {
       
        [unowned self] in
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph2: HTMLElement2? = HTMLElement2.init(name: "p", text: "hello, world")
print(paragraph2!.asHTML())

paragraph2 = nil















