import Foundation
import UIKit
import RealmSwift

class BankStatementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    private var bankStatementViewModel: BankStatementViewModel!
    private var isShow: Bool = false
    
    @IBOutlet weak var tableViewStatements: UITableView!
    @IBOutlet weak var bankStatementView: UIView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var bankStatementLabel: UILabel!
    @IBOutlet weak var viewAmountImageView: UIImageView!
    @IBOutlet weak var statementExtract: UILabel!
    @IBOutlet weak var bankStatementAmountHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.bankStatementViewModel = BankStatementViewModel()
        configureView()
        getAmount()
        getStatements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configureView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BankStatementViewController.showAmount(gesture:)))
        viewAmountImageView.addGestureRecognizer(tapGesture)
        viewAmountImageView.isUserInteractionEnabled = true
        changeIconImage()
        bankStatementLabel.textColor = hexStringToUIColor(hex: black)
        bankStatementView.backgroundColor = hexStringToUIColor(hex: lightGray)
        showOrHideAmount()
        tableViewStatements.register(UINib(nibName: "ItemBankStatementViewCellTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        tableViewStatements.delegate = self
        tableViewStatements.dataSource = self
    }
    
    func getAmount () {
        let localAmount = try! Realm()
        let amount = localAmount.object(ofType: LocalData.self, forPrimaryKey: 0)
        if amount != nil  && amount?.amount != 0 {
            self.amount.text = "R$" + (amount?.amount.description)! + ",00"
        }
        self.bankStatementViewModel.bindBankStatementAmountViewModel = {
            self.updateAmount()
        }
    }
    
    func getStatements () {
        self.bankStatementViewModel.bindBankStatementDataViewModel = {
            self.updateStatements()
        }
    }
    
    func updateAmount() {
        self.amount.text = String(format: "R$ %02d,00", self.bankStatementViewModel.amountData.amount)
    }
    
    func updateStatements() {
        self.tableViewStatements.reloadData()
    }
    
    func changeIconImage() {
        self.viewAmountImageView.image = UIImage(named: isShow ? "visibility" : "invisibility")
        self.viewAmountImageView.image = viewAmountImageView.image?.withRenderingMode(.alwaysTemplate)
        self.viewAmountImageView.tintColor = hexStringToUIColor(hex: lightGreen)
    }
    
    func showOrHideAmount() {
        bankStatementAmountHeightConstraint.constant = isShow ? 35 : 6
        amount.backgroundColor = isShow ? UIColor.clear : hexStringToUIColor(hex: lightGreen)
        amount.textColor = isShow ? hexStringToUIColor(hex: black) : hexStringToUIColor(hex: lightGreen)
    }
    
    @objc func showAmount(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            isShow = !isShow
            changeIconImage()
            showOrHideAmount()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bankStatementViewModel.statements != nil ? self.bankStatementViewModel.statements.items.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! ItemBankStatementViewCellTableViewCell
        cell.selectionStyle = .none
        let statementData = self.bankStatementViewModel.statements.items[indexPath.row]
        cell.amountLabel.text = cell.getFormated(amount: formatAmount(amount: statementData.amount) )
        cell.dateLabel.text = getDate(data: statementData.createdAt,formart: "yyyy-MM-dd'T'HH:mm:ssZ",newFormat: "dd/MM")
        cell.descriptionLabel.text = statementData.to == nil ? statementData.from : statementData.to
        cell.titleLable.text = getTitle(title: statementData.type)
        cell.isPix(isPix: statementData.type.lowercased().contains("pix"))
        if(indexPath.row == self.bankStatementViewModel.statements.items.count - 3) {
            self.bankStatementViewModel.getStatements()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetail(index: indexPath.row)
    }
    
    func showDetail(index: Int) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "bankDetailStatementViewController") as! BankDetailStatementViewController
        view.idDetail = self.bankStatementViewModel.statements.items[index].id
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
