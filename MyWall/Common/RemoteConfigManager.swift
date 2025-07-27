import FirebaseRemoteConfig
import RxSwift
import RxCocoa

class RemoteConfigManager {
    
    static let shared = RemoteConfigManager()
    
    enum RemoteConfigKeys: String {
        case clientID = "client_id"
    }
    
    private init() {
        loadDefaultValues()
    }
    
    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            RemoteConfigKeys.clientID.rawValue: ""
        ]
        
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        #if DEBUG
        settings.minimumFetchInterval = 0
        #else
        settings.minimumFetchInterval = 60 * 60 * 6
        #endif
        
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    func fetchData(completion: @escaping () -> Void) {
        activateDebugMode()
        
        RemoteConfig.remoteConfig().fetch { (_, error) in
            if error != nil {
                completion()
                return
            }
            
            RemoteConfig.remoteConfig().activate { _, _ in
                completion()
            }
        }
    }
    
    func fetchCloudValues() -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            self.activateDebugMode()

            RemoteConfig.remoteConfig().fetch { (_, error) in
                if error != nil {
                    observer.onNext(false)
                    observer.onCompleted()
                }

                RemoteConfig.remoteConfig().activate { (_, _) in
                    observer.onNext(true)
                    observer.onCompleted()
                }
            }

            return Disposables.create {}
        }
    }
    
    func bool(forKey key: RemoteConfigKeys) -> Bool {
        RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }

    func string(forKey key: RemoteConfigKeys) -> String {
      RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
    }
}
