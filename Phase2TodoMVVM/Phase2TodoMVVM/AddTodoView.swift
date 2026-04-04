import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""

    let onSave: (String) -> Void

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
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(title)
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTodoView(onSave: { _ in })
}

