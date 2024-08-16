import SwiftUI

struct WalkRowView: View {
    @AppStorage("measurementSystem") private var measurementSystem = "Imperial"
    let walk: Walk
    
    var body: some View {
        HStack {
            Image(systemName: "figure.walk")
                .frame(width: 50)
                .font(.title2)
            
            VStack(alignment: .leading, content: {
                Text(walk.name)
                    .font(.title3)
                    .bold()
                Text("\(walk.startPoint) ➔ \(walk.endPoint)")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            })
            
            Spacer()
            
            Text(String(format: "%.2f", formattedDistance)+" \(measurementSystem=="Metric" ? "km" : "mp")")
                .font(.title3)
                .bold()
        }
    }
    
    var formattedDistance: Double {
        if measurementSystem == "Imperial" {
            return walk.distance * 0.000621371
        } else {
            return walk.distance * 0.001
        }
    }
}

#Preview {
    WalkRowView(walk: Walk(name: "City walk", walkDescription: "my first walk", startPoint: "Arbat st.", endPoint: "Tverskoy av.", distance: 4.2, walkImage: nil))
}
