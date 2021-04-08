import Foundation
import RealmSwift

class BankStatementViewModel: NSObject {
    private var page: Int = 0
    private var apiController: ApiController!
    private let localData = try! Realm()
    private(set) var amountData : BalanceModel! {
        didSet {
            self.bindBankStatementAmountViewModel()
        }
    }
    private(set) var statements: BalanceStatementModel! {
        didSet{
            self.bindBankStatementDataViewModel()
        }
    }
        
    var bindBankStatementAmountViewModel : (() -> ()) = {}
    var bindBankStatementDataViewModel : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiController = ApiController()
        getAmount()
        getStatements()
    }
    
    func getAmount() {
        self.apiController.getAmount(completion: { (amountData) in
            var amount = self.localData.object(ofType: LocalData.self, forPrimaryKey: 0)
            amount = LocalData(amount: amountData.amount)
            try! self.localData.write { () -> Void in
                self.localData.add(amount!,update: .modified)
            }
            self.amountData = amountData
        })
    }
    
    func getStatements() {
        self.page = self.page + 1
        self.apiController.getBalanceStatement(page: self.page.description, completion: { (statements) in
            self.statements == nil ? self.statements = statements : self.statements.items.append(contentsOf: statements.items)
        })
    }
    
}
