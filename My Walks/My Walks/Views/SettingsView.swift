import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("measurementSystem") private var measurementSystem = "Imperial"
    @AppStorage("appLanguage") private var appLanguage = "English"
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Main settings") {
                    Picker("Measurement system", selection: $measurementSystem) {
                        Text("Imperial").tag("Imperial")
                        Text("Metric").tag("Metric")
                    }
                    Picker("App language", selection: $appLanguage) {
                        Text("English").tag("English")
                    }
                }
                Section("App design") {
                    Toggle("Dark Mode", isOn: $isDarkModeOn)
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
