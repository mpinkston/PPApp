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
    
    // Interpolating - 補間（ほかん）
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
    
    // Enumerating - 列挙する（れっきょ）
    print("---")
    for (idx, item) in fruits.enumerated() {
        print("\(idx): \(item)")
    }
    
    // Iterating - 反復する（はんぷく）
    print("---")
    for fruit in fruits {
        print(fruit)
    }
    
    // Concatenating - 連結する（れんけつ）
    print("---")
    print(fruits.joined(separator: ", "))
    
    // Split it back apart!
    print("---")
    print(fruits.joined(separator: ",").components(separatedBy: ","))
}

example("メソッドの定義") {
    // Basic method definition
    func firstMethod() {
        print("called \(#function)")
    }
    firstMethod()
    
    // Method with one required argument
    func secondMethod(withArgument: String) {
        print("called \(#function) \(withArgument)")
    }
    secondMethod(withArgument: "Pen")
    
    // Method with one named required argument
    func thirdMethod(withArgument arg: String) {
        print("called \(#function) \(arg)")
    }
    func thirdMethod(withIntArgument arg: Int) {
        print("called \(#function) \(arg)")
    }
    
    thirdMethod(withArgument: "Pineapple")
    thirdMethod(withIntArgument: 1234)
    
    func fourthMethod(_ arg: String) {
        print("called \(#function) \(arg)")
    }
    fourthMethod("Apple")
    
    func fifthMethod(_ arg: String, andASecondOptionalArgument arg2: String? = "Pineapple") {
        print("called \(#function) arg1: \(arg), arg2: \(arg2)")
    }
    fifthMethod("Pen")
    fifthMethod("Pen", andASecondOptionalArgument: nil)
    fifthMethod("Pen", andASecondOptionalArgument: "Cheeseburger")
}

example("戻り値") {
    func returnStringMethod() -> String {
        return "Hello, I'm \(#function)"
    }
    print(returnStringMethod())
    
    func returnOptionalStringMethod() -> String? {
        // return nil
        return "I'm \(#function)"
    }
    print(returnOptionalStringMethod())
    if let optionalString = returnOptionalStringMethod() {
        print(optionalString)
    } else {
        print("NOTHING!!")
    }
    
    print("--- Tuples!! ---")
    func returnTupleMethod(amount: Int) -> (Int, String) {
        return (amount, "Pen\(amount == 1 ? "" : "s")")
    }
    
    let (a, b) = returnTupleMethod(amount: 1)
    print("\(a) \(b)")
}

//: [Next](@next)
