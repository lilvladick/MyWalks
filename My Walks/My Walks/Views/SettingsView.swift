import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("measurementSystem") private var measurementSystem = "Imperial"
    @State private var appLanguage = "English"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Main settings"){
                    Picker("Measurement system", selection: $measurementSystem) {
                        Text("Metric")
                        Text("Imperial")
                    }
                    Picker("App language", selection: $appLanguage) {
                        Text("English")
                    }
                }
                Section("App deisgn") {
                    Toggle("Dark Mode", isOn: $isDarkModeOn)
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

#Preview {
    SettingsView()
}
