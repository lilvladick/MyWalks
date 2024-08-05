import SwiftUI
import MapKit
import CoreLocation

struct MainScreenView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var cameraPosition: MapCameraPosition = .region(.userRegion)
    
    var body: some View {
        Map(position: $cameraPosition) {
            if let userLocation = locationManager.location {
                Annotation("That's you", coordinate: userLocation.coordinate) {
                    ZStack {
                        Circle()
                            .stroke(Color.white, lineWidth: 5)
                        Circle()
                            .fill(Color.blue)
                    }
                    .frame(width: 10, height: 10)
                }
            }
        }
        .onAppear {
            if let userLocation = locationManager.location {
               cameraPosition = .region(MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000))
           }
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 55.7522, longitude: 37.6156)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted: break
            // alert user
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        @unknown default:
            break
        }
    }

}

#Preview {
    MainScreenView()
}
