import SwiftUI

@main
struct Phase3GitHubApp: App {
    @StateObject private var viewModel = RepositoryListViewModel(
        repositoryService: GitHubRepositoryService(session: .shared)
    )

    var body: some Scene {
        WindowGroup {
            RepositoryListView(viewModel: viewModel)
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = RepositoryListViewModel(
        repositoryService: GitHubRepositoryService(session: .shared)
    )
    RepositoryListView(viewModel: viewModel)
}
