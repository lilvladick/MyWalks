import SwiftUI
import SwiftData

struct SaveWalkFormView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @AppStorage("measurementSystem") private var measurementSystem = "Imperial"
    @State private var walkName = ""
    @State private var walkDescription = ""
    @Binding var locations: [String]
    @Binding var distance: Double
    var body: some View {
        NavigationStack {
            Form {
                /*
                 VStack {
                 if let walkImage = , let uiImage = UIImage(data: walkImage) {
                 Image(uiImage: uiImage)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(height: 150)
                 } else {
                 Text("No image available =(").frame(height: 100)
                 }
                 }*/
                
                Section("Walk name") {
                    TextField("Walk name", text: $walkName)
                }
                Section("Walk details") {
                    if locations.count == 2 {
                        Text(verbatim: "\(locations[0]) ➔ \(locations[1])")
                    } else {
                        Text(verbatim: "You stood still")
                    }
                    Text(verbatim: String(format: "%.2f", formattedDistance) + " \(measurementSystem=="Metric" ? "kilometers" : "miles")")
                }
                Section("Description") {
                    TextEditor(text: $walkDescription)
                        .frame(minHeight: 150)
                }
            }
            .foregroundStyle(isDarkmodeOn ? Color.white : Color.black)
            .navigationTitle("Adding new walk")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save") {
                        saveWalk()
                        dismiss()
                    }
                    .foregroundStyle(isDarkmodeOn ? Color.white : Color.black)
                    .disabled(walkName.isEmpty)
                })
            }
        }
    }
    
    var formattedDistance: Double {
        let distanceText = distance
        if measurementSystem == "Imperial" {
            return distanceText * 0.000621371
        } else {
            return distanceText * 0.001
        }
    }
    
    func saveWalk() {
        let newWalk = Walk(
            name: walkName,
            walkDescription: walkDescription,
            startPoint: locations[0],
            endPoint: locations[1],
            distance: distance,
            walkImage: nil
        )
        
        modelContext.insert(newWalk)
        
        do {
            try modelContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
/*
#Preview {
    SaveWalkFormView(locations: ["start","end"], distance: 2.2)
}*/
