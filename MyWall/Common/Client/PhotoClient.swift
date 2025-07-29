import RxSwift

protocol PhotoServices {
    func getTrending() -> Observable<PhotoContainer>
}

class PhotoClient: PhotoServices {
    func getTrending() -> Observable<PhotoContainer> {
        return APIClient.request(PhotoRouter.trending)
    }
}
