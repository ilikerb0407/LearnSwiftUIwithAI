import SwiftUI

struct ProfileCardView: View {
    private let profile: ProfileDisplayData

    @State private var isFollowing = false
    @State private var showMessageAcknowledgement = false

    init(profile: ProfileDisplayData = .sample) {
        self.profile = profile
    }

    var body: some View {
        VStack(spacing: ProfileLayout.sectionSpacing) {
            ProfileImageView(systemImageName: "person.crop.circle.fill")

            Text(profile.name)
                .font(.largeTitle.weight(.bold))
                .multilineTextAlignment(.center)

            Text(profile.bio)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            ProfileActionButtons(isFollowing: $isFollowing) {
                showMessageAcknowledgement = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, ProfileLayout.horizontalPadding)
        .alert("Message", isPresented: $showMessageAcknowledgement) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Message action tapped — connect your chat flow here.")
        }
    }
}

#Preview("Default") {
    ProfileCardView()
}

#Preview("Custom profile") {
    ProfileCardView(
        profile: ProfileDisplayData(
            name: "Jamie Lee",
            bio: "Short two-line bio example that truncates nicely in the layout preview here."
        )
    )
}
