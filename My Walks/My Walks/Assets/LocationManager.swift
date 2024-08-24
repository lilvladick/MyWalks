import Foundation
import ActivityKit
import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @AppStorage("walkIsPaused") private var walkIsPaused = false
    private let locationManager = CLLocationManager()
    @Published var totalDistance: CLLocationDistance = 0.0
    @Published var userLocation: CLLocation?
    @Published var locations: [CLLocationCoordinate2D] = []
    private var lastLocation: CLLocation?
    private var timer: Timer?
    var activity: Activity<MyWalksWidgetsAndActivityAttributes>?
    var isAuthorized = false

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    func getStartEndPoints(completion: @escaping ([String]) -> Void) {
        guard locations.count >= 2 else {
            print("Not enough locations")
            completion([])
            return
        }
        
        let startPoint = locations.first!
        let endPoint = locations.last!
        var points: [String] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        getLocation(from: startPoint) { point in
            if let point = point {
                points.append(point)
            } else {
                points.append("Start location not found")
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        getLocation(from: endPoint) { point in
            if let point = point {
                points.append(point)
            } else {
                points.append("End location not found")
            }
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: .main) {
            completion(points)
        }
    }

    private func getLocation(from coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                if let street = placemark.thoroughfare {
                    completion(street)
                } else if let locality = placemark.locality {
                    completion(locality)
                } else if let administrativeArea = placemark.administrativeArea {
                    completion(administrativeArea)
                } else {
                    completion("Unknown location")
                }
            } else {
                completion("Placemark not found")
            }
        }
    }
    
    func startActivity() {
        let initialContentState = MyWalksWidgetsAndActivityAttributes.ContentState(distance: 0.0)
        let activityAttributes = MyWalksWidgetsAndActivityAttributes(name: "Current Walk")
        
        do {
            let activityContent = ActivityContent(state: initialContentState, staleDate: Date().addingTimeInterval(24*60*60))
            activity = try Activity<MyWalksWidgetsAndActivityAttributes>.request(
                attributes: activityAttributes,
                content: activityContent
            )
            
            startTrackingDistance()
        } catch {
            print("Error Live Activity: \(error.localizedDescription)")
        }
    }
    
    func stopActivity() {
        stopTrackingDistance()
        
        if let activity = activity {
            let finalContentState = MyWalksWidgetsAndActivityAttributes.ContentState(distance: totalDistance)
            let finalContnet = ActivityContent(state: finalContentState, staleDate: Date().addingTimeInterval(24*60*60))
            Task {
                await activity.end(finalContnet, dismissalPolicy: .immediate)
            }
        }
    }
    
    private func startTrackingDistance() {
        print("start")
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.getDistance()
        }
        print("timer start")
    }
    
    @objc func getDistance() {
        print("getting distance")
        if let activity = activity {
            print("activity")
            let updatedContentState = MyWalksWidgetsAndActivityAttributes.ContentState(distance: totalDistance)
            print(totalDistance)
            let updatedContent = ActivityContent(state: updatedContentState, staleDate: Date().addingTimeInterval(24*60*60))
            Task {
                await activity.update(updatedContent)
            }
        }
    }
    
    private func stopTrackingDistance() {
        timer?.invalidate()
        timer = nil
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
    
    /**
     
     */
    func stopLocationServices() {
        locationManager.stopUpdatingLocation()
    }
    
    func clearLocationsArray() {
        locations.removeAll()
        totalDistance = 0.0
        lastLocation = nil
    }
    
    /**
     
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            userLocation = location
            
            if let lastLocation = lastLocation {
                let distance = location.distance(from: lastLocation)
                totalDistance += distance
            }
            
            lastLocation = location

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
