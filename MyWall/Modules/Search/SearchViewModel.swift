import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
    
    // MARK: - Properties
    private var photoServices: PhotoServices
    
    init(photoServices: PhotoServices = PhotoClient()) {
        self.photoServices = photoServices
    }
    
    struct Input {
        let getDataTrigger: Observable<Int>
    }
    
    struct Output {
        let loadingEvent: Driver<Bool>
        let errorEvent: Driver<Error>
        let getDataEvent: Driver<[PhotoElement]>
    }
    
    func transform(input: Input) -> Output {
        let loading = ActivityIndicator()
        let error = ErrorTracker()
        
        let getDataEvent = input.getDataTrigger
            .flatMapLatest(weak: self) { (self, page) in
                self.photoServices
                    .getTrending(page: page)
                    .trackError(error)
                    .trackActivity(loading)
            }
            .map { $0.photos }
        
        return Output(
            loadingEvent: loading.asDriver(),
            errorEvent: error.asDriver(),
            getDataEvent: getDataEvent.asDriverOnErrorJustComplete()
        )
    }
}

