import SwiftUI

struct ControlPanelView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @AppStorage("walkIsStarted") private var walkIsStarted = false
    @AppStorage("walkIsPaused") private var walkIsPaused = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    // LIST OF WALKS
                    Button(action: {
                        // Action for listing walks
                    }, label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 25))
                    })
                    .frame(width: 60, height: 60)
                    .background(isDarkModeOn ? Color.black.opacity(0.5) : Color.white.opacity(0.7))
                    .clipShape(Circle())
                    
                    Spacer()
                    
                    // START OR RESUME WALK
                    Button(action: {
                        if !walkIsStarted {
                            walkIsStarted = true
                        } else {
                            showAlert.toggle()
                        }
                    }, label: {
                        Image(systemName: walkIsStarted ? "pause" : "play")
                            .font(.system(size: 45))
                    })
                    .frame(width: 100, height: 100)
                    .background(isDarkModeOn ? Color.black.opacity(0.5) : Color.white.opacity(0.7))
                    .clipShape(Circle())
                    
                    Spacer()
                    
                    // SETTINGS
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName:"gearshape")
                            .frame(width: 60, height: 60)
                            .font(.system(size: 25))
                            .background(isDarkModeOn ? Color.black.opacity(0.5) : Color.white.opacity(0.7))
                            .clipShape(Circle())
                        }
                }
                .padding(.horizontal)
                .foregroundStyle(isDarkModeOn ? Color.white : Color.black)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Select action"),
                        message: Text("Select an action according to your action"),
                        primaryButton: .default(Text("Pause")) {
                            walkIsPaused = true
                        },
                        secondaryButton: .destructive(Text("Stop")) {
                            walkIsStarted = false
                            walkIsPaused = false
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    ControlPanelView()
}
