import Foundation

protocol GitHubRepositoryServing {
    func fetchRepositories(forUsername username: String) async throws -> [Repository]
}

/// Network layer: GitHub REST API only. Views must not call this directly.
struct GitHubRepositoryService: GitHubRepositoryServing {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    func fetchRepositories(forUsername username: String) async throws -> [Repository] {
        let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw GitHubAPIError.invalidUsername }

        guard let encoded = trimmed.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            throw GitHubAPIError.invalidUsername
        }

        guard let url = URL(string: "https://api.github.com/users/\(encoded)/repos?per_page=30&sort=updated") else {
            throw GitHubAPIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        // GitHub 建議提供 User-Agent；未帶時可能被限流或拒絕。
        request.setValue("Phase3GitHubViewer", forHTTPHeaderField: "User-Agent")

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw error
        }

        guard let http = response as? HTTPURLResponse else {
            throw GitHubAPIError.invalidResponse
        }

        guard (200 ..< 300).contains(http.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw GitHubAPIError.httpStatus(code: http.statusCode, message: message)
        }

        guard !data.isEmpty else {
            throw GitHubAPIError.noData
        }

        do {
            return try decoder.decode([Repository].self, from: data)
        } catch {
            throw GitHubAPIError.decodingFailed
        }
    }
}
