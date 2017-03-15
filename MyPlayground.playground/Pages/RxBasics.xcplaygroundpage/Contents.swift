//: [Previous](@previous)

import RxSwift
import RxCocoa

let observable1 = Observable.just("Pen")

example("Subscribing") {
    _ = observable1.subscribe(onNext: { (value) in
        print(value)
    }, onError: { error in
        print(error)
    }, onCompleted: { _ in
        print("done")
    })
}

example("Another way to subscribe") {
    _ = observable1.subscribe { (event) in
        switch event {
        case .next(let value):
            print(value)
        case .error(let error):
            print(error)
        case .completed:
            print("done")
        }
    }
}
/*:
 Multiple values
 */
let observable2 = Observable.from([1, 2, 3, 4, 5])

example("Multiple values") {
    _ = observable2.subscribe(onNext: { (value) in
        print(value)
    }, onCompleted: { _ in
        print("done")
    })
}

// Publish subject (with error)
let strPublisher = PublishSubject<String>()
example("Publish subject") {
    strPublisher.asObservable().subscribe(onNext: { (value) in
        print(value)
    }, onError: { error in
        print("An error occurred: \(error)")
    })
    strPublisher.onNext("Apple")
    strPublisher.onError(TestError.test)
    
    // エラーが起こったから、strPublisherは退会された。
    strPublisher.onNext("Pineappe")
}


// 初期値設定必須
let strVariable = Variable<String>("Apple")

example("Variable") {
    // サブスクライブすると、初期値がすぐに出る
    strVariable.asObservable().subscribe(onNext: { (value) in
        print(value)
    })
    
    print("値が変わったら。。")
    strVariable.value = "Pineapple"
}

let strOrNilVariable = Variable<String?>(nil)

example("Int or Nil Variable") {
    strOrNilVariable.asObservable().subscribe(onNext: { (value) in
        print("\(value ?? "The value is nil!")")
    })
    
    print("値が変わったら。。")
    strOrNilVariable.value = "Pineaple"
}

//: [Next](@next)
