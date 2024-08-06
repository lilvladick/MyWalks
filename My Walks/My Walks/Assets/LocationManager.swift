import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @AppStorage("walkIsPaused") private var walkIsPaused = false
    private let locationManager = CLLocationManager()
    @Published var userLocation: CLLocation?
    @Published var locations: [CLLocationCoordinate2D] = []
    var isAuthorized = false
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    /**
     
     */
    func startLocationServices() {
        switch locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.allowsBackgroundLocationUpdates = true
                locationManager.startUpdatingLocation()
                isAuthorized = true
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            default:
                isAuthorized = false
        }
    }
    
    func stopLocationServices() {
        locationManager.stopUpdatingLocation()
        
        if !walkIsPaused {
            locations.removeAll()
        }
    }
    
    /**
     
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location

            let newCoordinate = location.coordinate
            self.locations.append(newCoordinate)
        }
    }
    
    /**
     
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            isAuthorized = false
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Access restricted")
        case .denied:
            isAuthorized = false
            print("Access denied")
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            locationManager.requestLocation()
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    /**
     
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
