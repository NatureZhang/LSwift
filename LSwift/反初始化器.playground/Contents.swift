//: 有点类似于 dealloc

//: #### 反初始化
/*:
 当操作自己的资源时，可能需要在释放实例时执行一些额外的清理工作。比如，创建了一个自定义类来打开某文件写点数据进去，就要在实例释放之前关闭这个文件  
 反初始化器会在实例被释放之前自动被调用，不能手动调用反初始化器。父类的反初始化器可以被子类继承，并且子类的反初始化器实现结束之后父类的反初始化器会被调用。父类的反初始化器总会被调用，即使子类没有反初始化器。  
 由于实例在反初始化器被调用之前都不会被释放，反初始化器可以访问实例中的所有属性并且可以基于这些属性修改自身行为
 
 */


class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}


class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player.init(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
var playerTwo: Player? = Player.init(coins: 500)

print("There are now \(Bank.coinsInBank) coins left in the bank")

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank now only has \(Bank.coinsInBank) coins left")


playerOne = nil
playerTwo = nil
print("PlayerOne has left the game")
print("The bank now has \(Bank.coinsInBank) coins")




