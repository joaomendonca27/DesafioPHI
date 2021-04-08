import Foundation
import UIKit

class BankDetailStatementViewController: UIViewController {
    
    var idDetail: String!
    private var bankDetailStatementViewModel: BankDetailStatementViewModel!
    
    @IBOutlet weak var descriptionStatement: UILabel!
    @IBOutlet weak var amountStatement: UILabel!
    @IBOutlet weak var personStatement: UILabel!
    @IBOutlet weak var dateStatement: UILabel!
    @IBOutlet weak var autenticationStatement: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var viewStatement: UIView!
    
    @IBAction func sharedStatement(_ sender: UIButton) {
        sharedView(view: self.viewStatement,viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bankDetailStatementViewModel = BankDetailStatementViewModel()
        self.bankDetailStatementViewModel.getDetailStatement(idStatement: idDetail)
        getDetail()
        configureShareButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = hexStringToUIColor(hex: black)
        self.navigationController?.navigationItem.backBarButtonItem  = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func configureShareButton() {
        shareButton.backgroundColor = hexStringToUIColor(hex: lightGreen)
    }
    
    func getDetail() {
        self.bankDetailStatementViewModel.bindBankStatementDataViewModel = {
            self.updateDetail()
        }
    }
    
    func updateDetail() {
        self.descriptionStatement.text = getTitle(title: self.bankDetailStatementViewModel.detail.type)
        self.personStatement.text = self.bankDetailStatementViewModel.detail.to == nil ? self.bankDetailStatementViewModel.detail.from : self.bankDetailStatementViewModel.detail.to
        self.autenticationStatement.text = self.bankDetailStatementViewModel.detail.authentication
        self.dateStatement.text = getDate(data: self.bankDetailStatementViewModel.detail.createdAt, formart: "yyyy-MM-dd'T'HH:mm:ssZ", newFormat: "dd/MM/yyyy - HH:mm:ss")
        self.amountStatement.text = "R$ " + self.bankDetailStatementViewModel.detail.amount.description + ",00"
    }
    
}
