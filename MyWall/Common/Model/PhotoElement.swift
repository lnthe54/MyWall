import Foundation

struct PhotoContainer: Codable {
    let photos: [PhotoElement]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

struct PhotoElement: Codable {
    let id: Int?
    let width: Int?
    let height: Int?
    let url: String?
    let photographer: String?
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String?
    let source: SourceElement?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case width = "width"
        case height = "height"
        case url = "url"
        case photographer = "photographer"
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case source = "src"
    }
}

struct SourceElement: Codable {
    let original: String?
    let large2X: String?
    let large: String?
    let medium: String?
    let small: String?
    let portrait: String?
    let landscape: String?
    let tiny: String?
    
    enum CodingKeys: String, CodingKey {
        case original = "original"
        case large2X = "large2x"
        case large = "large"
        case medium = "medium"
        case small = "small"
        case portrait = "portrait"
        case landscape = "landscape"
        case tiny = "tiny"
    }
}
