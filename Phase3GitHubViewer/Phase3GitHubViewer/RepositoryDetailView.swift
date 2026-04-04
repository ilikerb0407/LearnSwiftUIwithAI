import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository

    var body: some View {
        List {
            Section("Repository") {
                LabeledContent("Name", value: repository.name)
                LabeledContent("Full name", value: repository.fullName)
            }

            Section("About") {
                Text(repository.description ?? "No description")
                    .foregroundStyle(repository.description == nil ? .tertiary : .primary)
            }

            Section("Stats") {
                LabeledContent("Stars") {
                    HStack(spacing: 6) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(repository.stargazersCount)")
                            .monospacedDigit()
                    }
                }
            }

            Section("Web") {
                if let url = URL(string: repository.htmlURL) {
                    Link(destination: url) {
                        Label("Open on GitHub", systemImage: "safari")
                    }
                }
            }
        }
        .navigationTitle(repository.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RepositoryDetailView(
            repository: Repository(
                id: 1,
                name: "swift",
                fullName: "apple/swift",
                description: "The Swift Programming Language",
                stargazersCount: 68_000,
                htmlURL: "https://github.com/apple/swift"
            )
        )
    }
}
