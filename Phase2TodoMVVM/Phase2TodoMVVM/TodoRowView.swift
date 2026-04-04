import SwiftUI

struct TodoRowView: View {
    let todo: Todo
    let onToggle: () -> Void

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
        .onTapGesture(perform: onToggle)
    }
}

#Preview {
    TodoRowView(
        todo: Todo(title: "Read Swift docs", isCompleted: true),
        onToggle: {}
    )
    .padding()
}

