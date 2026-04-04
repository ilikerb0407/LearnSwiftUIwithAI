import Foundation

enum TodoFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case completed = "Completed"
    case incomplete = "Incomplete"

    var id: Self { self }
}

