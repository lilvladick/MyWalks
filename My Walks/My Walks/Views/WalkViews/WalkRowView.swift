import SwiftUI

struct WalkRowView: View {
    @AppStorage("measurementSystem") private var measurementSystem = "Imperial"
    let walk: Walk
    
    var body: some View {
        HStack {
            Image(systemName: "figure.walk").frame(width: 50)
            
            VStack(alignment: .leading, content: {
                Text(walk.name)
                Text("\(walk.startPoint) ➔ \(walk.endPoint)")
            })
            
            Spacer()
            
            Text(String(format: "%.2f", walk.distance)+" \(measurementSystem=="Metric" ? "km" : "mp")")
        }
    }
}

#Preview {
    WalkRowView(walk: Walk(name: "City walk", walkDescription: "my first walk", startPoint: "Arbat st.", endPoint: "Tverskoy av.", distance: 4.2, walkImage: nil))
}
