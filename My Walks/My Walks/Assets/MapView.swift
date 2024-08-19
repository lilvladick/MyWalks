import SwiftUI
import MapKit

/**
 An add-on for MKMapView that implements UIViewRepresentable,
 which allows you to use UIKit elements in SwiftUI.
 */
struct MapView: UIViewRepresentable {
    /**
     An array of user route coordinates and
     center coordinates that use the CLLocationCoordinate2D data type.
     */
    var locations: [CLLocationCoordinate2D]
    var locationCenter: CLLocationCoordinate2D?
    
    /**
     A helper class that handles delegate methods.
     It inherits from NSObject and implements MKMapViewDelegate.
     */
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(parent: MapView) {
            self.parent = parent
        }
        /**
         A method for creating and customizing a render to display overlays on a map.
         First, a check is made to ensure that the object is an MKPolyline. If this is not the case, then an empty render is returned.
         If this is an MKPolyline object, then the line is adjusted (color and thickness) and the finished render is returned.
         */
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let render = MKPolylineRenderer(polyline: polyline)
                render.strokeColor = .red
                render.lineWidth = 8.0
                return render
            }
            return MKOverlayRenderer()
        }
    }
    
    /**
     Allows you to call the Coordinator class to work with delegate methods.
     */
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    /**
     An MKMapView instance is created and a delegate is set to update map events.
     A flag is also set to display the user's location. Afterwards the configured MapView is returned.
     */
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }
    
    /**
     The method first removes the previous overlay and then sets up a new user route. Next, the line is added to the map.
     Then it is checked whether there is a centering coordinate. 
     If yes, then the region for its display is set. Afterwards the region is installed with animation.
     */
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        uiView.addOverlay(polyline)
        
        if let locationCenter = locationCenter {
            let region = MKCoordinateRegion(center: locationCenter, latitudinalMeters: 1000, longitudinalMeters: 1000)
            uiView.setRegion(region, animated: true)
        } else if let firstLocation = locations.first {
            let region = MKCoordinateRegion(center: firstLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            uiView.setRegion(region, animated: true)
        }
    }
    
    func createSnapshot(completion: @escaping (UIImage?) -> Void) {
        let region = MKCoordinateRegion(
            center: locationCenter ?? locations.first ?? CLLocationCoordinate2D(latitude: 0, longitude: 0),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = CGSize(width: 300, height: 300)
        
        let snapshotter = MKMapSnapshotter(options: options)
        
        snapshotter.start { snapshotOrNil, _ in
            if let snapshot = snapshotOrNil {
                completion(snapshot.image)
            } else {
                completion(nil)
            }
        }
    }
}
