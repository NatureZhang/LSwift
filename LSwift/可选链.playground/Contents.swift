
//: #### 可选连
/*:
 可选链是在可能递归为 nil 的可选项中查询和调用属性、方法和下标的过程。如果可选项包含值，属性、方法或者下标的调用成功；如果可选项是 nil ，属性、方法或者下标的调用会返回 nil 。多个查询可以链接在一起，如果链中任何一个节点是 nil ，那么整个链就会得体地失败。
 */

class Person0 {
    var residence: Residence0?
}

class Residence0 {
    var numberOfRooms = 1
}

let john0 = Person0()
// 如果强制展开它的值，会触发一个运行时错误，因为 residence 根本没有值可以展开
//let roomCount = john.residence!.numberOfRooms

//: 可选链提供另一种访问 numberOfRooms 的方法，要使用可选链，使用 ？ 而不是 ！
if let roomCount = john0.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}

john0.residence = Residence0()

if let roomCount = john0.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms.")
}

//: #### 为可选链定义模型类
//: 你可以使用可选链来调用属性、方法和下标，不止一个层级。这允许你在相关类型的复杂模型中深入到子属性，并检查是否可以在这些子属性里访问属性、方法和下标。

class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        }
        else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        }
        else {
            return nil
        }
    }
}

//: #### 通过可选链访问属性
//: 可以使用可选链来访问可选值里的属性，并且检查这个属性访问是否成功
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress

//: 这个赋值是可选链的一部分，也就是说 = 运算符右手侧的代码都不会被评判

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
john.residence?.address = createAddress()

//: createAddress() 函数没有被调用，因为没有任何东西打印出来。

//: #### 通过可选链调用方法
//: 可以使用可选链来调用可选项里的方法，并且检查调用是否成功
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

//: 任何通过可选链设置属性的尝试都会返回一个 Void? 类型值，它允许你与 nil 比较来检查属性是否设置成功
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

//: #### 通过可选链访问下标
//: 可以使用可选链来给可选项下标取回或设置值，并且检查下标的调用是否成功
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name")
}

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

//: #### 访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
print(testScores)

//: #### 链的多层连接
//: 可以通过连接多个可选链来在模型中深入访问属性、方法以及下标。总之，多层可选链不会给返回的值添加多层的可选性。

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
} else {
    print("Unable to retrieve the address")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

//: #### 用可选返回值链接方法
//: 可以通过可选链来调用返回可选类型的方法，并且如果需要的话可以继续对方法的返回值进行链接
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

//: 如果要进一步对方法的返回值进行可选链，在方法 buildingIdentifier() 的圆括号后面加上可选链 问 号

if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
















