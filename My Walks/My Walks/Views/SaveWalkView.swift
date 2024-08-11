import SwiftUI

struct SaveWalkView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var locationManager: LocationManager
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @State private var showSavingForm = false
    @State var locationArray: [String] = []
    @State private var totalDistance: Double = 0.0
    
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
                    dismiss()
                }
                .padding()
                .frame(width: 120, height: 40)
                .background(Color.red)
                .foregroundStyle(isDarkmodeOn ? Color.black : Color.white).bold()
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                
                Button("Save") {
                    locationManager.getStartEndPoints { points in
                        locationArray = points
                        print(locationArray)
                        totalDistance = locationManager.totalDistance
                        showSavingForm.toggle()
                    }
                }
                .fullScreenCover(isPresented: $showSavingForm, content: {
                    SaveWalkFormView(locations: locationArray, distance: totalDistance)
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
}

#Preview {
    SaveWalkView()
}
