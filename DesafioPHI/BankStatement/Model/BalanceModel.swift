import Foundation
struct BalanceModel: Decodable {

    let amount: Int

    enum CodingKeys: String, CodingKey {
        case amount = "amount"
    }
}
