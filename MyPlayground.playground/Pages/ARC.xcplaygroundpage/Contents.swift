//: [Previous](@previous)
import SwiftyTimer
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


class Apple {
    var id: Int = 0
    var strongPen: Pen?
    weak var weakPen: Pen?
    
    init(id: Int = 0) {
        self.id = id
    }
}

class Pen {
    var id: Int = 0
    var strongApple: Apple?
    weak var weakApple: Apple?
    
    init(id: Int = 0) {
        self.id = id
    }
    
    func writeMessage() {
        Timer.after(1.second) { [weak self] _ in
            guard let me = self else {
                print("#### Penインスタンスが破棄された ####")
                return
            }
            print("#### インスタンス Pen(\(me.id)) はまだここにいますよ。####")
        }
    }
}

example("強参照") {
    var strongApple1 = Apple() // strongApple1 ARC + 1 (参照数: 1)
    print(type(of: strongApple1))
    print(strongApple1)
}

example("弱参照") {
    weak var weakApple1 = Apple() // weakApple1 ARC + 0 (参照数: 0)
    print(type(of: weakApple1))
    print(weakApple1) // <-- nil! 参照の無い変数はすぐ破棄される
}

example("複数参照") {
    var apple1, apple2, apple3: Apple?
    
    apple1 = Apple(id: 123) // Apple(123) ARC + 1 (total: 1)
    apple2 = apple1  // Apple(123) ARC + 1 (total: 2)
    apple3 = apple1  // Apple(123) ARC + 1 (total: 3)

    apple1 = nil // Apple(123) ARC - 1 (total: 2)
    print(apple1?.id)
    print(apple2?.id)
    print(apple3?.id)
    if apple2 === apple3 {
        print("同じインスタンス\n")
    }
    
    apple2 = nil // Apple(123) ARC - 1 (total: 1)
    print(apple1?.id)
    print(apple2?.id)
    print(apple3?.id)
    
    apple3 = nil // Apple(123) ARC - 1 (total: 0) 破棄する
    print(apple1?.id)
    print(apple2?.id)
    print(apple3?.id)
}

print("--- 循環参照 ---")
var invincibleApple: Apple? = Apple() // Apple ARC + 1 (total: 1)
var invinciblePen: Pen? = Pen(id: 9000) // Pen ARC + 1 (total: 1)

invincibleApple!.strongPen = invinciblePen // Pen ARC + 1 (total: 2)
invinciblePen!.strongApple = invincibleApple // Apple ARC + 1 (total: 2)

invinciblePen = nil // Pen ARC - 1 (total: 1)
print(invincibleApple?.strongPen) // 参照が残っているから破棄されない
print(invincibleApple?.strongPen?.strongApple?.strongPen?.strongApple) // 循環参照
invincibleApple?.strongPen?.writeMessage()
// invincibleAppleを「nil」に設定しても、互いに参照があるため、メモリに残る。メモリリーク!!!!
invincibleApple = nil // Apple ARC - 1 (total: 1) AppleもPenも参照残っている


print("--- 循環参照防止 ---")
var goodApple: Apple? = Apple() // Apple ARC + 1 (total: 1)
var goodPen: Pen? = Pen(id: 100) // Pen ARC + 1 (total: 1)

goodApple!.strongPen = goodPen // Pen ARC + 1 (total: 2)
goodPen!.weakApple = goodApple // Apple ARC + 0 (total: 1)

goodPen = nil // Pen ARC - 1 (total: 1)
print(goodApple!.strongPen)
print(goodApple!.strongPen?.weakApple)
goodApple?.strongPen?.writeMessage()
goodApple = nil // Apple ARC - 1 (total: 0) 破棄される - goodApple?.strongPen の参照も消えるから、Pen ARC - 1 (total: 0) 破棄される
