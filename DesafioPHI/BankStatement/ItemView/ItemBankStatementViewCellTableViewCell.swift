import UIKit

class ItemBankStatementViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var pixFlagLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configurePixStatus()
        configureDescription()
        configureDate()
        configureAmount()
        configureTitle()
        createCircleView()
    }
    
    private func configurePixStatus() {
        pixFlagLabel.backgroundColor = hexStringToUIColor(hex: lightGreen)
        pixFlagLabel.textColor = UIColor.white
    }
    
    private func configureDescription() {
        descriptionLabel.textColor = hexStringToUIColor(hex: gray)
    }
    
    private func configureDate() {
        dateLabel.textColor = hexStringToUIColor(hex: gray)
    }
    
    private func configureAmount() {
        amountLabel.textColor = hexStringToUIColor(hex: black)
    }
    
    private func configureTitle() {
        titleLable.textColor = hexStringToUIColor(hex: black)
    }
    
    private func createCircleView() {
        circleImageView.image = UIImage(named: "circle")
        circleImageView.image = circleImageView.image?.withRenderingMode(.alwaysTemplate)
        circleImageView.tintColor = hexStringToUIColor(hex: lightGreen)
    }
    
    func getFormated(amount: String) -> String {
        return "R$" + amount + ",00"
    }
    
    func isPix(isPix: Bool) {
        pixFlagLabel.isHidden = !isPix
    }
    
}
