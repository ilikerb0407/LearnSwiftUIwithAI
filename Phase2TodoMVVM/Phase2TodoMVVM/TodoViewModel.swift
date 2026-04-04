import Foundation
import Combine

@MainActor
final class TodoViewModel: ObservableObject {
    @Published private(set) var todos: [Todo] = []
    @Published var selectedFilter: TodoFilter = .all

    private let store: TodoStoring

    var filteredTodos: [Todo] {
        switch selectedFilter {
        case .all:
            return todos
        case .completed:
            return todos.filter(\.isCompleted)
        case .incomplete:
            return todos.filter { !$0.isCompleted }
        }
    }

    init(store: TodoStoring = UserDefaultsTodoStore()) {
        self.store = store
        let loaded = store.loadTodos()
        if loaded.isEmpty {
            todos = [
                Todo(title: "Learn MVVM"),
                Todo(title: "Add persistence", isCompleted: true)
            ]
            persist()
        } else {
            todos = loaded
        }
    }

    func addTodo(title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        todos.append(Todo(title: trimmed))
        persist()
    }

    func deleteTodos(at offsets: IndexSet) {
        let filtered = filteredTodos
        let idsToDelete = offsets.map { filtered[$0].id }
        todos.removeAll { idsToDelete.contains($0.id) }
        persist()
    }

    func toggleTodo(id: UUID) {
        guard let index = todos.firstIndex(where: { $0.id == id }) else { return }
        todos[index].isCompleted.toggle()
        persist()
    }

    private func persist() {
        store.saveTodos(todos)
    }
}

