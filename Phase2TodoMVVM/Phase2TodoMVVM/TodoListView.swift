import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel: TodoViewModel
    @State private var isShowingAddSheet = false

    init(viewModel: TodoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    ForEach(TodoFilter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top, 8)

                List {
                    ForEach(viewModel.filteredTodos) { todo in
                        TodoRowView(todo: todo) {
                            viewModel.toggleTodo(id: todo.id)
                        }
                    }
                    .onDelete(perform: viewModel.deleteTodos)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add todo")
                }
            }
            .sheet(isPresented: $isShowingAddSheet) {
                AddTodoView { title in
                    viewModel.addTodo(title: title)
                }
            }
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoViewModel())
}

