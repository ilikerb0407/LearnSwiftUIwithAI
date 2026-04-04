import SwiftUI

@main
struct Phase2TodoMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView(viewModel: TodoViewModel())
        }
    }
}

