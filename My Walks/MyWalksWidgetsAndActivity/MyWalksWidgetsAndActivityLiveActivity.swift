import ActivityKit
import WidgetKit
import SwiftUI

struct MyWalksWidgetsAndActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var distance: Double
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyWalksWidgetsAndActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyWalksWidgetsAndActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            HStack {
                Image(systemName: "figure.walk").font(.title).padding(.horizontal)
                Text("\(context.state.distance * 0.001, specifier: "%.2f") kilometrs")
                    .font(.title)
                    .bold()
            }
            .activityBackgroundTint(Color.clear)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "figure.walk.motion").font(.title)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("\(context.state.distance * 0.001, specifier: "%.2f") kilometrs")
                        .font(.title2)
                        .bold()
                }
            } compactLeading: {
                Image(systemName: "figure.walk")
            } compactTrailing: {
                Text("\(context.state.distance * 0.001, specifier: "%.1f") km")
            } minimal: {
                
            }
            .keylineTint(Color.red)
        }
    }
}

extension MyWalksWidgetsAndActivityAttributes {
    fileprivate static var preview: MyWalksWidgetsAndActivityAttributes {
        MyWalksWidgetsAndActivityAttributes(name: "World")
    }
}

