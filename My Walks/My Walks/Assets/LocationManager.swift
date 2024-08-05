import Foundation
import SwiftUI
import CoreLocation

class LocationManager: NSObject ,ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var isAuthorized = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        startLocationServices()
    }
    
    func startLocationServices() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            isAuthorized = true
        } else {
            isAuthorized = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
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
            print("error")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
