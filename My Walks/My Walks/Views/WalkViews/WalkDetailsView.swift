import SwiftUI
import SwiftData

struct WalkDetailsView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("measurementSystem") private var measurementSystem = "Imperial"
    
    @State var walk: Walk
    @State private var walkName: String
    @State private var walkDescription: String
    
    init(walk: Walk) {
        _walk = State(initialValue: walk)
        _walkName = State(initialValue: walk.name)
        _walkDescription = State(initialValue: walk.walkDescription ?? "")
    }
    
    var formattedDistance: Double {
        let distanceText = walk.distance
        if measurementSystem == "Imperial" {
            return distanceText * 0.000621371
        } else {
            return distanceText * 0.001
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                if walk.walkImage == nil {
                    Text("No image")
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        .padding()
                } else {
                    let image = UIImage(data: walk.walkImage!)
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        .padding()
                }
                
                Form {
                    Section("Walk information"){
                        TextField("", text: $walkName)
                        Text(verbatim: "\(walk.startPoint) ➔ \(walk.endPoint)")
                        Text(verbatim: String(format: "%.2f", formattedDistance) + " \(measurementSystem=="Metric" ? "kilometers" : "miles")")
                    }
                    Section("Description"){
                        TextEditor(text: $walkDescription).frame(height: 150)
                    }
                }
            }
            .preferredColorScheme(isDarkmodeOn ? .dark : .light)
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Update") {
                        updateWalk()
                    }
                }
            }
        }
    }
    
    private func updateWalk() {
        walk.name = walkName
        walk.walkDescription = walkDescription
        
        try? modelContext.save()
    }
}

#Preview {
    WalkDetailsView(walk: Walk(name: "City walk", walkDescription: "my first walk", startPoint: "Arbat st.", endPoint: "Tverskoy av.", distance: 4.2, walkImage: nil))
}
