import Alamofire
import RxSwift

class APIClient {
    
    static let sessionManagerWithoutAuthentication: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.waitsForConnectivity = true
        let networkLogger = NetworkLogger()
        return Session(configuration: configuration, eventMonitors: [networkLogger])
    }()
    
    static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            
            sessionManagerWithoutAuthentication.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                    
                case .failure(let error):
                    let apiError = mapAPIError(statusCode: response.response?.statusCode, error: error)
                    observer.onError(apiError)
                }
            }
            
            return Disposables.create {}
        }
    }
    
    private static func mapAPIError(statusCode: Int?, error: Error) -> APIError {
        switch statusCode {
        case 204:
            return APIError.noContent
        case 400:
            return APIError.badRequest
        case 401:
            return APIError.unauthorized
        case 403:
            return APIError.forbidden
        case 404:
            return APIError.notFound
        case 405:
            return APIError.noAllowed
        case 409:
            return APIError.conflict
        case 500:
            return APIError.internalServerError
        default:
            return APIError.unknown(error)
        }
    }
}
