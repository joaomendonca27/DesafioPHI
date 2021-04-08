import Alamofire

class ApiController {
    
    let headers: HTTPHeaders = [
        .accept("application/json"),
        .init(name: "token", value: token)
    ]
    
    func getAmount(completion : @escaping (BalanceModel) -> ()) {
        AF.request(urlBase + myBalance,method: .get,headers: headers).responseDecodable(of: BalanceModel.self){ response in
            if let data = response.data  {
                let jsonDecoder = JSONDecoder()
                let balanceModel = try! jsonDecoder.decode(BalanceModel.self, from: data)
                completion(balanceModel)
            }
        }.resume()
    }
    
    func getBalanceStatement(page:String, completion : @escaping (BalanceStatementModel) -> ()) {
        AF.request(urlBase + setStatementDataRequest(limit: "9", offset: page), method: .get, headers: headers).responseDecodable(of: BalanceStatementModel.self) { response in
            if let data = response.data  {
                let jsonDecoder = JSONDecoder()
                let balanceStatementModel = try! jsonDecoder.decode(BalanceStatementModel.self, from: data)
                completion(balanceStatementModel)
            }
        }.resume()
    }
    
    func getDetail(id: String, completion: @escaping (BalanceStatementModelData) -> ()) {
        AF.request(urlBase + detail + id, method: .get, headers: headers).responseDecodable(of: BalanceStatementModelData.self) { response in
            if let data = response.data  {
                let jsonDecoder = JSONDecoder()
                let balanceStatementDataModel = try! jsonDecoder.decode(BalanceStatementModelData.self, from: data)
                completion(balanceStatementDataModel)
            }
        }.resume()
    }
    
}
