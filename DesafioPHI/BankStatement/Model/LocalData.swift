import RealmSwift

class LocalData: Object {
    @objc dynamic var id = 0
    @objc dynamic var amount: Int = 0
    
    convenience init (amount: Int) {
        self.init()
        self.amount = amount
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
