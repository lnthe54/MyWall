import RxSwift

protocol PhotoServices {
    func getTrending(page: Int) -> Observable<PhotoContainer>
}

class PhotoClient: PhotoServices {
    func getTrending(page: Int) -> RxSwift.Observable<PhotoContainer> {
        return APIClient.request(PhotoRouter.trending(page: page))
    }
}
