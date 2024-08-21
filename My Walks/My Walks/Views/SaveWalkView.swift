import SwiftUI
import MapKit
import CoreLocation

struct SaveWalkView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var locationManager: LocationManager
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @State private var showSavingForm = false
    @State private var locationArray: [String] = []
    @State private var totalDistance: CLLocationDistance = 0.0
    @State private var mapImage: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Save this walk?")
                .font(.title)
                .foregroundStyle(isDarkmodeOn ? Color.white : Color.black)
                .bold()
                .padding(.vertical)
            Text("You can save the path you have taken. In the future, you will be able to view your saved walks.")
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundStyle(Color.gray)
            HStack {
                Button("No, thanks") {
                    locationManager.clearLocationsArray()
                    dismiss()
                }
                .padding()
                .frame(width: 120, height: 40)
                .background(Color.red)
                .foregroundStyle(isDarkmodeOn ? Color.black : Color.white).bold()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                
                Button("Save") {
                    totalDistance = locationManager.totalDistance
                    locationManager.getStartEndPoints { points in
                        locationArray = points
                        
                        createSnapshot { image in
                            mapImage = image
                            showSavingForm.toggle()
                        }
                    }
                }
                .fullScreenCover(isPresented: $showSavingForm, content: {
                    SaveWalkFormView(locations: $locationArray, distance: $totalDistance, mapImage: $mapImage)
                })
                .padding()
                .frame(width: 120, height: 40)
                .background(isDarkmodeOn ? Color.white : Color.black)
                .foregroundStyle(isDarkmodeOn ? Color.black : Color.white).bold()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            }
            .padding(.vertical)
        }
    }
    
    func createSnapshot(completion: @escaping (UIImage?) -> Void) {
            
        let region = MKCoordinateRegion(
            center: locationManager.locations.last ?? CLLocationCoordinate2D(latitude: 0, longitude: 0),
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        
        let options = MKMapSnapshotter.Options()
        options.region = region
        options.size = CGSize(width: 400, height: 250)
        options.scale = UIScreen.main.scale
        
        let snapshotter = MKMapSnapshotter(options: options)
        
        snapshotter.start { snapshotOrNil, _ in
            guard let snapshot = snapshotOrNil else {
                completion(nil)
                return
            }
            
            let image = UIGraphicsImageRenderer(size: options.size).image { context in
                snapshot.image.draw(at: .zero)
                
                context.cgContext.setStrokeColor(UIColor.red.cgColor)
                context.cgContext.setLineWidth(8.0)
                
                let points = locationManager.locations.map { location in
                    snapshot.point(for: location)
                }
                
                context.cgContext.addLines(between: points)
                context.cgContext.strokePath()
            }
            
            completion(image)
        }
    }
    
}

#Preview {
    SaveWalkView()
}
