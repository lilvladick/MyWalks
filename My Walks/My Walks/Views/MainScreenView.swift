import MapKit
import SwiftUI

struct MainScreenView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
        }
        .onAppear {
            updateCameraPosition()
        }
    }
    
    func updateCameraPosition() {
        if let userLocation = locationManager.userLocation {
            let userRegion = MKCoordinateRegion(
                center: userLocation.coordinate,
                span: MKCoordinateSpan(
                    latitudeDelta: 0.3,
                    longitudeDelta: 0.3
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
