//: [Previous](@previous)
import UIKit
import SwiftyTimer
import PlaygroundSupport

/*:
 # Named Types
 ## Class, Protocol, Enum
 */
//: [Next](@next)

let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
container.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = container
PlaygroundPage.current.needsIndefiniteExecution = true

enum Color {
    case red
    case blue
    case black
}

// Enums can have raw values
enum NamedColor: String {
    case red = "Red"
    case blue = "Blue"
    case black = "Black"
}
if let namedColor1 = NamedColor(rawValue: "Red") {
    print(namedColor1)
}
if let namedColor2 = NamedColor(rawValue: "Purple") {
    print(namedColor2)
} else {
    print("namedColor2 is nil!!")
}

// Enums can be auto-indexed
enum IndexedColor: Int {
    case red = 0
    case blue
    case black
}
let indexedColor1 = IndexedColor(rawValue: 0)
print(indexedColor1 ?? "empty")

// protocol: (similar to an Interface)
protocol WritingImplement: class {

    var color: Color { get set } // but required properties can be specified

    func write(_ text: String)
    
    func erase()
}

// Class that implements a protocol
class Pen: WritingImplement {
    
    var color: Color = Color.black {
        willSet { // Properties can have observers!
            print("Color will change to \(newValue)")
        }
        didSet {
            print("Color changed to \(color)")
        }
    }
    
    func write(_ text: String) {
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: 190, height: 20))
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.text = text
        
        switch color {
        case .red:
            label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        case .black:
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        case .blue:
            label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        
        container.addSubview(label)
    }
    
    func erase() {
        for subview in container.subviews {
            subview.removeFromSuperview()
        }
    }
    
    init(withColor color: Color) {
        self.color = color
    }
}

let writer = Pen(withColor: .red)
writer.write("Hello!!")

Timer.after(2.seconds) { 
    writer.erase()
    writer.color = .blue
    writer.write("How are you?")
}





