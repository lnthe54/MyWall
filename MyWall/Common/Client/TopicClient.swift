import RxSwift

protocol TopicServices {
    func getCategories() -> Observable<[CategoryElement]>
}

class TopicClient: TopicServices {
    func getCategories() -> Observable<[CategoryElement]> {
        return APIClient.request(TopicRouter.topics)
    }
}
