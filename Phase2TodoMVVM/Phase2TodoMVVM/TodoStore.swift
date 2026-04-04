import Foundation

protocol TodoStoring {
    func loadTodos() -> [Todo]
    func saveTodos(_ todos: [Todo])
}

struct UserDefaultsTodoStore: TodoStoring {
    private let defaults: UserDefaults
    private let key: String

    init(defaults: UserDefaults = .standard, key: String = "phase2.todos") {
        self.defaults = defaults
        self.key = key
    }

    func loadTodos() -> [Todo] {
        guard let data = defaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Todo].self, from: data)) ?? []
    }

    func saveTodos(_ todos: [Todo]) {
        guard let data = try? JSONEncoder().encode(todos) else { return }
        defaults.set(data, forKey: key)
    }
}

