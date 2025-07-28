// MARK: - CategoryElement
struct CategoryElement: Codable {
    let id: String?
    let slug: String?
    let title: String?
    let coverPhoto: PhotoElement?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case title = "title"
        case coverPhoto = "cover_photo"
    }
}
