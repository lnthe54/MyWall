import RxSwift
import RxCocoa

class SplashViewModel: ViewModelType {
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getDataEvent = input.getDataTrigger
            .flatMapLatest {
                RemoteConfigManager.shared.fetchCloudValues()
                    .trackError(error)
                    .trackActivity(loading)
            }
        
        return Output(
            loadingEvent: loading.asDriver(),
            errorEvent: error.asDriver(),
            getDataEvent: getDataEvent.asDriverOnErrorJustComplete()
        )
    }
}

extension SplashViewModel {
    struct Input {
        let getDataTrigger: Observable<Void>
    }
    
    struct Output {
        let loadingEvent: Driver<Bool>
        let errorEvent: Driver<Error>
        let getDataEvent: Driver<Bool>
    }
}
