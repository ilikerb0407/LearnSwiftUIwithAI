import SwiftUI

struct AddTodoView: View {
    @Binding var todos: [Todo]
    @Environment(\.dismiss) private var dismiss

    @State private var title: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Todo") {
                    TextField("e.g. Buy milk", text: $title)
                        .textInputAutocapitalization(.sentences)
                }
            }
            .navigationTitle("Add Todo")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        addTodo()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func addTodo() {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        todos.append(Todo(title: trimmed))
        dismiss()
    }
}

#Preview("Add Todo") {
    AddTodoPreviewWrapper()
}

private struct AddTodoPreviewWrapper: View {
    @State private var todos: [Todo] = []

    var body: some View {
        AddTodoView(todos: $todos)
    }
}

