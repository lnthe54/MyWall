import RxSwift
import RxCocoa

class DiscoverViewModel: ViewModelType {
 
    // MARK: - Properties
    private var photoServices: PhotoServices
    private var topicServices: TopicServices
    
    init(
        photoServices: PhotoServices = PhotoClient(),
        topicServices: TopicServices = TopicClient()
    ) {
        self.photoServices = photoServices
        self.topicServices = topicServices
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
        
        let getTrendingData = input.getDataTrigger
            .flatMapLatest(weak: self) { (self, _) in
                self.photoServices
                    .getTrending()
                    .trackError(error)
                    .trackActivity(loading)
            }
        
        let getCategoriesData = input.getDataTrigger
            .flatMapLatest(weak: self) { (self, _) in
                self.topicServices
                    .getCategories()
                    .trackError(error)
                    .trackActivity(loading)
            }
        
        let getDataEvent = Observable.zip(getTrendingData, getCategoriesData)
            .map { (trendings, categories) in
                return DiscoverData(trendingItems: trendings, categories: categories)
            }
        
        return Output(
            loadingEvent: loading.asDriver(),
            errorEvent: error.asDriver(),
            getDataEvent: getDataEvent.asDriverOnErrorJustComplete()
        )
    }
}

struct DiscoverData {
    var trendingItems: [PhotoElement]
    
    var categories: [CategoryElement]
    
    static func empty() -> DiscoverData {
        return DiscoverData(
            trendingItems: [],
            categories: []
        )
    }
}
