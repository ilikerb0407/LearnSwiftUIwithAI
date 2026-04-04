import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack(spacing: 12) {
                        TextField("GitHub username", text: $viewModel.username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .textFieldStyle(.roundedBorder)

                        Button("載入") {
                            Task { await viewModel.loadRepositories() }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.isLoading)
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                }

                if viewModel.isLoading {
                    Section {
                        HStack {
                            Spacer()
                            ProgressView("Loading…")
                            Spacer()
                        }
                    }
                }

                if let message = viewModel.errorMessage {
                    Section {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(message)
                                .foregroundStyle(.red)
                                .font(.subheadline)
                            Button("重試") {
                                Task { await viewModel.loadRepositories() }
                            }
                            .buttonStyle(.bordered)
                        }
                        .padding(.vertical, 4)
                    }
                }

                Section("Repositories") {
                    ForEach(viewModel.repositories) { repo in
                        NavigationLink(value: repo) {
                            RepositoryRowView(repository: repo)
                        }
                    }
                }
            }
            .navigationTitle("GitHub Repos")
            .navigationDestination(for: Repository.self) { repo in
                RepositoryDetailView(repository: repo)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task { await viewModel.loadRepositories() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                    .accessibilityLabel("重新載入")
                    .disabled(viewModel.isLoading)
                }
            }
            .task {
                await viewModel.loadRepositories()
            }
        }
    }
}

#Preview {
    RepositoryListView(
        viewModel: RepositoryListViewModel(
            repositoryService: GitHubRepositoryService(session: .shared)
        )
    )
}
