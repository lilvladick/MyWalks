import MapKit
import SwiftUI

struct MainScreenView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showSettings = false
    @State private var showSaveWalkSheet = false
    
    var body: some View {
        NavigationStack {
            MapView(locations: locationManager.locations,locationCenter: locationManager.userLocation?.coordinate)
                .ignoresSafeArea()
            .overlay {
                VStack{
                    ControlPanelView(showSaveWalkSheet: $showSaveWalkSheet)
                        .environmentObject(locationManager)
                        .padding(.horizontal)
                }
            }
        }
        .sheet(isPresented: $showSaveWalkSheet) {
            SaveWalkView()
                .environmentObject(locationManager)
                .presentationDetents([.fraction(0.30)])
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
}

#Preview {
    MainScreenView()
}
