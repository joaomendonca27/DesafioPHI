import Foundation
class BankDetailStatementViewModel: NSObject {
    
    private var apiController: ApiController!
    private(set) var detail: BalanceStatementModelData! {
        didSet{
            self.bindBankStatementDataViewModel()
        }
    }
    
    var bindBankStatementDataViewModel : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiController = ApiController()
    }
    
    func getDetailStatement(idStatement: String) {
        self.apiController.getDetail(id: idStatement, completion: { ( detail ) in
            self.detail = detail
        })
    }
}
