//: [Previous](@previous)

// Struct is value type!!
example("Struct") {
    struct User {
        var name: String = ""
        var address: String = ""
        
        func show() {
            print("\(name) : \(address)")
        }
    }
    
    var user1 = User(name: "Bob", address: "1234 Somewhere Rd.")
    var user2 = user1
    
    user2.name = "Fred"
    user2.address = "1515 Main St."

    user1.show()
    user2.show()
    
    // Value types cannot be weak!
    // weak var user3 = User(name: "Fred", address: "1234234") ❌
}

// Class is reference type!!
example("Class") {
    class User {
        var name: String = ""
        var address: String = ""
        
        func show() {
            print("\(name) : \(address)")
        }
        
        init(name: String, address: String) {
            self.name = name
            self.address = address
        }
    }

    var user1 = User(name: "Bob", address: "1234 Somewhere Rd.")
    var user2 = user1
    
    user2.name = "Fred"
    user2.address = "1515 Main St."
    
    user1.show()
    user2.show()
}


//: [Next](@next)
