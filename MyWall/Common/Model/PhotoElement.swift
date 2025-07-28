import Foundation

struct PhotoElement: Codable {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var width: Int?
    var height: Int?
    var color: String?
    var description: String?
    var urls: URLElement?
    var links: LinkElement?
    var likes: Int?
    var likedByUser: Bool?
    var assetType: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width = "width"
        case height = "height"
        case color = "color"
        case description = "description"
        case urls = "urls"
        case links = "links"
        case likes = "likes"
        case likedByUser = "liked_by_user"
        case assetType = "asset_type"
    }
}

struct URLElement: Codable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    var smallS3: String?

    enum CodingKeys: String, CodingKey {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
        case smallS3 = "small_s3"
    }
}

struct LinkElement: Codable {
    var linksSelf: String?
    var html: String?
    var download: String?
    var downloadLocation: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html = "html"
        case download = "download"
        case downloadLocation = "download_location"
    }
}
