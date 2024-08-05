import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle("Dark Mode", isOn: $isDarkModeOn)
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

#Preview {
    SettingsView()
}
