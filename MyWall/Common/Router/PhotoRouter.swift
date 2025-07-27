import Alamofire

enum PhotoRouter: APIConfiguration {
    case trending
    
    var hostURL: String {
        return Constants.Network.hostURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .trending:
            return "photos"
        }
    }
    
    var requestParams: APIRequestParams? {
        switch self {
        case .trending:
            return getParams(request: PhotoRequest(orderBy: "popular", perPage: 20))
        }
    }
}

struct PhotoRequest {
    var orderBy: String? = nil
    var perPage: Int = 10
}
