import SwiftUI

struct ProfileActionButtons: View {
    @Binding var isFollowing: Bool
    var onMessage: () -> Void

    var body: some View {
        HStack(spacing: ProfileLayout.actionButtonSpacing) {
            Button {
                isFollowing.toggle()
            } label: {
                Text(isFollowing ? "Following" : "Follow")
                    .frame(maxWidth: .infinity, minHeight: ProfileLayout.buttonMinHeight)
            }
            .buttonStyle(.borderedProminent)

            Button(action: onMessage) {
                Text("Message")
                    .frame(maxWidth: .infinity, minHeight: ProfileLayout.buttonMinHeight)
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview("Actions") {
    StatefulPreviewWrapper(false) { binding in
        ProfileActionButtons(isFollowing: binding, onMessage: {})
            .padding()
    }
}

/// Helper for previews that need `@Binding` without a parent view.
private struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private let content: (Binding<Value>) -> Content

    init(_ initial: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initial)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
