import Foundation

/// Subset of GitHub `GET /users/{user}/repos` item.
struct Repository: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let htmlURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case stargazersCount = "stargazers_count"
        case htmlURL = "html_url"
    }
}
