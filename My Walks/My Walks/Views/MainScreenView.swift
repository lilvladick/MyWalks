import MapKit
import SwiftUI

struct MainScreenView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            MapView(locations: locationManager.locations,locationCenter: locationManager.userLocation?.coordinate)
                .ignoresSafeArea()
            .overlay {
                VStack{
                    ControlPanelView()
                        .environmentObject(locationManager)
                        .padding(.horizontal)
                }
            }
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

#Preview {
    MainScreenView()
}
