import Foundation
import Combine

@MainActor
final class RepositoryListViewModel: ObservableObject {
    @Published var username: String = "apple"
    @Published private(set) var repositories: [Repository] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private let repositoryService: GitHubRepositoryServing

    init(repositoryService: GitHubRepositoryServing) {
        self.repositoryService = repositoryService
    }

    func loadRepositories() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            repositories = try await repositoryService.fetchRepositories(forUsername: username)
        } catch let apiError as GitHubAPIError {
            errorMessage = apiError.localizedDescription
        } catch {
            errorMessage = "網路連線失敗：\(error.localizedDescription)"
        }
    }
}
