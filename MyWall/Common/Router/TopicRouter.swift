import Alamofire

enum TopicRouter: APIConfiguration {
    case topics
    
    var hostURL: String {
        return Constants.Network.hostURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .topics:
            return "topics"
        }
    }
    
    var requestParams: APIRequestParams? {
        switch self {
        case .topics:
            return getParams(request: ComoponentRequest(orderBy: "featured"))
        }
    }
}
