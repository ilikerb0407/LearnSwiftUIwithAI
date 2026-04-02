import Foundation

/// Static content for the profile card (could later load from API or persistence).
struct ProfileDisplayData: Equatable {
    let name: String
    let bio: String

    static let sample = ProfileDisplayData(
        name: "Alex Chen",
        bio: "iOS developer learning SwiftUI. Building small apps and sharing what I learn along the way."
    )
}
