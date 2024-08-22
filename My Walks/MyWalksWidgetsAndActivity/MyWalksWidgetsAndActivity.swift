import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor 
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), walk: getLongestWalk())
    }

    @MainActor
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), walk: getLongestWalk())
        completion(entry)
    }

    @MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let timeline = Timeline(entries: [SimpleEntry(date: .now, walk: getLongestWalk())], policy: .after(.now.advanced(by: 60 * 5)))
        completion(timeline)
    }
    
    @MainActor 
    private func getLongestWalk() -> Walk? {
        guard let modelContainer = try? ModelContainer(for: Walk.self) else {
            return nil
        }
        let descriptor = FetchDescriptor<Walk>()
        let walks = try? modelContainer.mainContext.fetch(descriptor)
        if let walks = walks {
            return walks.max { $0.distance < $1.distance }
        } else {
            return nil
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let walk: Walk?
}

struct MyWalksWidgetsAndActivityEntryView : View {
    var entry: Provider.Entry
    var body: some View {
        VStack {
            if let walk = entry.walk {
                if walk.walkImage == nil {
                    Text("No image")
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color.gray)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                } else {
                    let image = UIImage(data: walk.walkImage!)
                    Image(uiImage: image!)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                }
                Text(String(format: "%.2f", walk.distance * 0.001) + " km").bold().font(.title3)
                Text("\(String(describing: walk.name))").font(.caption)
            } else {
                Text("You haven't saved any walks yet").font(.title3).bold()
            }
        }
    }
}

struct MyWalksWidgetsAndActivity: Widget {
    let kind: String = "MyWalksWidgetsAndActivity"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MyWalksWidgetsAndActivityEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MyWalksWidgetsAndActivityEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Longest Walk")
        .description("This widget shows your longest walk.")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    MyWalksWidgetsAndActivity()
} timeline: {
    SimpleEntry(date: .now, walk: Walk(name: "City walk", walkDescription: "my first walk", startPoint: "Arbat st.", endPoint: "Tverskoy av.", distance: 4.2, walkImage: nil))
}
