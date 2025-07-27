import Alamofire

final class NetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.isecure.NetworkingRxSwift")
    
    func requestDidFinish(_ request: Request) {
#if DEBUG
        guard let httpRequest = request.request else {
            print("❌ Request is nil.")
            return
        }
        
        let method = httpRequest.httpMethod ?? "Unknown Method"
        let url = httpRequest.url?.absoluteString ?? "Unknown URL"
        let headers = httpRequest.allHTTPHeaderFields ?? [:]
        
        var bodyString = ""
        if let httpBody = httpRequest.httpBody,
           let body = try? JSONSerialization.jsonObject(with: httpBody, options: .mutableContainers),
           let prettyData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            bodyString = prettyString
        }
        
        print("""
        ━━━━━━━━━━━━━━━━━━━━ 📤 REQUEST ━━━━━━━━━━━━━━━━━━━━━━━
        🔁 METHOD: \(method)
        🌐 URL: \(url)
        🧾 HEADERS: \(headers)
        📦 BODY:
        \(bodyString.isEmpty ? "No Body" : bodyString)
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        """)
#endif
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
#if DEBUG
        guard let data = response.data else {
            print("⚠️ No response data.")
            return
        }

        let url = request.request?.url?.absoluteString ?? "Unknown URL"
        let statusCode = response.response?.statusCode ?? 0
        
        var responseString = "Unable to parse JSON"
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            responseString = prettyString
        }

        print("""
        ━━━━━━━━━━━━━━━━━━━ 📥 RESPONSE ━━━━━━━━━━━━━━━━━━━━━━━
        🌐 URL: \(url)
        📡 STATUS CODE: \(statusCode)
        📨 RESPONSE BODY:
        \(responseString)
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        """)
#endif
    }
}
