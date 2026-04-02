import SwiftUI

struct ProfileImageView: View {
    let systemImageName: String
    var diameter: CGFloat = ProfileLayout.imageDiameter

    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .scaledToFit()
            .padding(diameter * 0.18)
            .frame(width: diameter, height: diameter)
            .background(.thinMaterial)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .strokeBorder(.secondary.opacity(0.35), lineWidth: 1)
            }
            .accessibilityLabel("Profile picture")
    }
}

#Preview("Profile image") {
    ProfileImageView(systemImageName: "person.crop.circle.fill")
        .padding()
}
