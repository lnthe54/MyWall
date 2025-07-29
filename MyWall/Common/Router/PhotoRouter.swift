import Alamofire

enum PhotoRouter: APIConfiguration {
    case trending(page: Int)
    
    var hostURL: String {
        return Constants.Network.hostURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .trending:
            return "curated"
        }
    }
    
    var requestParams: APIRequestParams? {
        switch self {
        case .trending(let page):
            return getParams(request: ComoponentRequest(page: page))
        }
    }
}
