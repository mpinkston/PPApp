//: [Previous](@previous)
import RealmSwift

/*:
 ## Realm
 Download the documentation at: https://realm.io/
 */


class CachedItem: Object {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    var age = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

var config = Realm.Configuration()
config.inMemoryIdentifier = "TestRealm"

let realm = try! Realm(configuration: config)

let firstItem = CachedItem()
firstItem.id = 1
firstItem.name = "PicoTaro"
firstItem.age.value = nil

try! realm.write {
    realm.add(firstItem)
}

let secondItem = CachedItem(value: ["id": 2, "name": "Bob", "age": 25])
realm.beginWrite()
realm.add(secondItem)
try! realm.commitWrite()


for item in realm.objects(CachedItem.self) {
    print(item.name)
}

print("----")

if let pico = realm.object(ofType: CachedItem.self, forPrimaryKey: 1) {
    print(pico)
}

if let guy = realm.objects(CachedItem.self).filter("name = %@", "Bob").first {
    print(guy)
}


//: [Next](@next)
