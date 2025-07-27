import RxSwift

protocol PhotoServices {
    func getTrending() -> Observable<[PhotoElement]>
}

class PhotoClient: PhotoServices {
    func getTrending() -> Observable<[PhotoElement]> {
        return APIClient.request(PhotoRouter.trending)
    }
}
