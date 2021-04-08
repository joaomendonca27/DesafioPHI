struct BalanceStatementModel: Decodable {
    
    var items: [BalanceStatementModelData]
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
    }
}



struct BalanceStatementModelData: Decodable {

    let id, type, createdAt, description: String
    let to, from, authentication: String?
    let amount: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "tType"
        case to = "to"
        case from = "from"
        case authentication = "authentication"
        case createdAt = "createdAt"
        case description = "description"
        case amount = "amount"
    }
}
