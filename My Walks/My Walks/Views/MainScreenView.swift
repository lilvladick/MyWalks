import MapKit
import SwiftUI

struct MainScreenView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            Map(position: $cameraPosition) {
                UserAnnotation()
            }
            .mapControls {
                MapUserLocationButton()
            }
            .onAppear {
                updateCameraPosition()
            }
            .overlay {
                VStack{
                    ControlPanelView()
                }
            }
        }
        .preferredColorScheme(isDarkModeOn ? .dark : .light)
    }
    
    func updateCameraPosition() {
        if let userLocation = locationManager.userLocation {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2
                )
            )
            withAnimation {
                cameraPosition = .region(userRegion)
            }
        }
    }
}

#Preview {
    MainScreenView()
}
