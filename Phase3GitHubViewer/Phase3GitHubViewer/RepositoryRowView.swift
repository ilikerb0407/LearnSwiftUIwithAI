import SwiftUI

struct RepositoryRowView: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(repository.name)
                .font(.headline)

            if let description = repository.description, !description.isEmpty {
                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            } else {
                Text("No description")
                    .font(.subheadline)
                    .foregroundStyle(.tertiary)
                    .italic()
            }

            HStack(spacing: 6) {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(repository.stargazersCount)")
                    .font(.subheadline.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RepositoryRowView(
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
