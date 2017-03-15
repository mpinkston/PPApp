//: [Previous](@previous)

import Foundation

// Defining variables
example("変数の定義") {
    var str = "I have a pen."
    print(str)
    
    // Concatenate - 連結する
    str += " I have an apple"
    print(str)
    
    let str2 = "Apple Pen"
    print(str2)
    
    // str2 += "pineapple" はだめ！　`let`で定義した変数は不変
    
    // Interpolating - 補間
    print("\(str): \(str2)")
    print(String(format: "%@: %@", str, str2))
}


example("配列") {
    var fruits: [String] = ["Apple"]
    var 果物 = Array<String>(["りんご"])
    print(type(of: fruits))
    print(type(of: 果物))
    
    if type(of: fruits) == type(of: 果物) {
        print("同じタイプ")
    }
    
    fruits.append("Pineapple")
    
    // Enumerating - 列挙する
    print("---")
    for (idx, item) in fruits.enumerated() {
        print("\(idx): \(item)")
    }
    
    // Iterating - 反復する
    print("---")
    for fruit in fruits {
        print(fruit)
    }
    
    // Concatenating - 連結する
    print("---")
    print(fruits.joined(separator: ", "))
    
    // Split it back apart!
    print("---")
    print(fruits.joined(separator: ",").components(separatedBy: ","))
}

//: [Next](@next)
