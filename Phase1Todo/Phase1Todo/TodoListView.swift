import SwiftUI

struct TodoListView: View {
    @State private var todos: [Todo] = [
        Todo(title: "Learn SwiftUI"),
        Todo(title: "Build a tiny app", isCompleted: true)
    ]

    @State private var isShowingAddTodo = false

    var body: some View {
        NavigationStack {
            List {
                ForEach($todos, id: \.id) { $todo in
                    TodoRowView(todo: $todo)
                }
                .onDelete(perform: deleteTodos)
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddTodo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add todo")
                }
            }
            .sheet(isPresented: $isShowingAddTodo) {
                AddTodoView(todos: $todos)
            }
        }
    }

    private func deleteTodos(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

#Preview("Todo list") {
    TodoListView()
}

