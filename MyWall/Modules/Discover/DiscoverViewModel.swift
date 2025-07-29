import RxSwift
import RxCocoa

class DiscoverViewModel: ViewModelType {
 
    // MARK: - Properties
    private var photoServices: PhotoServices
    
    init(
        photoServices: PhotoServices = PhotoClient()
    ) {
        self.photoServices = photoServices
    }
    
    struct Input  {
        let getDataTrigger: Observable<Void>
    }
    
    struct Output {
        let loadingEvent: Driver<Bool>
        let errorEvent: Driver<Error>
        let getDataEvent: Driver<DiscoverData>
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getDataEvent = input.getDataTrigger
            .flatMapLatest(weak: self) { (self, _) in
                self.photoServices
                    .getTrending()
                    .trackError(error)
                    .trackActivity(loading)
            }
            .map { DiscoverData(trendingItems: $0.photos) }
        
        return Output(
            loadingEvent: loading.asDriver(),
            errorEvent: error.asDriver(),
            getDataEvent: getDataEvent.asDriverOnErrorJustComplete()
        )
    }
}

struct DiscoverData {
    var trendingItems: [PhotoElement]
    
    static func empty() -> DiscoverData {
        return DiscoverData(
            trendingItems: []
        )
    }
}
