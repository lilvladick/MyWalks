import SwiftUI

struct ControlPanelView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("walkIsStarted") private var walkIsStarted = false
    @AppStorage("walkIsPaused") private var walkIsPaused = false
    @State private var showAlert = false
    @EnvironmentObject private var locationManager: LocationManager
    @Binding var showSaveWalkSheet: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    // LIST OF WALKS
                    NavigationLink(destination: WalkListView()) {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 25))
                            .frame(width: 60, height: 60)
                            .background(isDarkModeOn ? Color.black.opacity(0.6) : Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    // START OR RESUME WALK
                    Button(action: {
                        if !walkIsStarted {
                            walkIsStarted = true
                            locationManager.clearLocationsArray()
                            locationManager.startLocationServices()
                        } else {
                            walkIsPaused = true
                            showAlert.toggle()
                            locationManager.stopLocationServices()
                        }
                    }, label: {
                        Image(systemName: walkIsStarted ? "pause" : "play")
                            .font(.system(size: 45))
                    })
                    .frame(width: 100, height: 100)
                    .background(isDarkModeOn ? Color.black.opacity(0.6) : Color.white.opacity(0.7))
                    .clipShape(Circle())
                    
                    Spacer()
                    
                    // SETTINGS
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName:"gearshape")
                            .frame(width: 60, height: 60)
                            .font(.system(size: 25))
                            .background(isDarkModeOn ? Color.black.opacity(0.6) : Color.white.opacity(0.7))
                            .clipShape(Circle())
                        }
                }
                .padding(.horizontal)
                .foregroundStyle(isDarkModeOn ? Color.white : Color.black)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Select action"),
                        message: Text("Select an action according to your action"),
                        primaryButton: .default(Text("Resume")) {
                            walkIsPaused = false
                            locationManager.startLocationServices()
                        },
                        secondaryButton: .destructive(Text("Stop")) {
                            walkIsStarted = false
                            walkIsPaused = false
                            locationManager.stopLocationServices()
                            showSaveWalkSheet = true
                        }
                    )
                }
            }
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

/*#Preview {
    ControlPanelView()
}*/
