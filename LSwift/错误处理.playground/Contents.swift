
//: #### 表示和抛出错误
//: 在swift中，错误表示为遵循ErrorType协议类型的值，这个空的协议明确了一个类型可以用于错误处理

enum VendingMachineError: Error {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}

//: 使用 throw 语句来抛出一个错误
throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

//: #### 使用抛出函数传递错误
//: 为了明确一个函数或者方法可以抛出错误，要在它的声明当中的形式参数后边写上 throws 关键字。使用 throws 标记的函数叫做抛出函数。如果他明确了一个返回类型，那么 throws 关键字要在返回箭头 （->）之前
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    
    var inventory = [
    "Candy Bar": Item(price: 12, count: 7),
    "Chips": Item(price: 10, count: 4),
    "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        
        guard var item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        item.count -= 1
        inventory[name] = item
        dispenseSnack(snack: name)
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

/*:
 buyFavoriteSnack(person:vendingMachine:)函数查找给定人的最爱零食并且尝试通过调用 vend(itemNamed:)方法来购买它们。由于 vend(itemNamed:) 方法会抛出错误，调用的时候要在前边用 try关键字。
 */

//: #### 使用do-catch处理错误
/*:
     do {
         try expression
         statements
     } catch pattern 1 {
         statements
     } catch pattern 2 where condition {
         statements
     }
 */

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.OutOfStock {
    print("Out of Stock.")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}
//: 如果抛出错误，执行会立即切换到 catch分句，它决定是否传递来继续。如果没有错误抛出， do语句中剩下的语句将会被执行

//: #### 转换错误为可选项
//: 使用try？通过将错误转换为可选项来处理一个错误。如果一个错误在 try？表达式中抛出，则表达式的值为 nil

//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
//    return nil
//}

//: #### 取消错误传递 
/*:
 事实上有时已经知道一个抛出错误或者方法不会在运行时抛出错误。这种情况下，可以在表达式前写 try！来取消错误传递并且把调用放进不会有错误抛出的运行时断言当中。如果错误抛出了，会得到一个运行时错误  
 let photo = try! loadImage("./Resources/John Appleseed.jpg")
 */

//: #### 指定清理操作
/*:
 
 defer语句延迟执行直到当前范围退出。这个语句由 defer关键字和需要稍后执行的语句组成。被延迟执行的语句可能不会包含任何会切换控制出语句的代码，比如 break或 return语句，或者通过抛出一个错误。延迟的操作与其指定的顺序相反执行——就是说，第一个 defer语句中的代码会在第二个中代码执行完毕后执行，以此类推。
 
 
     func processFile(filename: String) throws {
        if exists(filename) {
         let file = open(filename)
         defer {
             close(file)
         }
         while let line = try file.readline() {
         // Work with the file.
         }
     // close(file) is called here, at the end of the scope.
         }
     }

 */













































