import SwiftUI

struct TodoRowView: View {
    @Binding var todo: Todo

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(todo.isCompleted ? .green : .secondary)

            Text(todo.title)
                .foregroundStyle(todo.isCompleted ? .secondary : .primary)
                .strikethrough(todo.isCompleted)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            // Tap the row to toggle completion.
            todo.isCompleted.toggle()
        }
        .accessibilityLabel(todo.title)
        .accessibilityHint(todo.isCompleted ? "Mark as incomplete" : "Mark as complete")
    }
}

#Preview("Todo row") {
    TodoRowPreviewWrapper(isCompleted: false)
}

#Preview("Todo row true") {
    TodoRowPreviewWrapper(isCompleted: true)
}

private struct TodoRowPreviewWrapper: View {
    @State var todo: Todo

    init(isCompleted: Bool) {
        _todo = State(initialValue: Todo(title: "Buy groceries", isCompleted: isCompleted))
    }

    var body: some View {
        TodoRowView(todo: $todo)
            .padding()
    }
}

