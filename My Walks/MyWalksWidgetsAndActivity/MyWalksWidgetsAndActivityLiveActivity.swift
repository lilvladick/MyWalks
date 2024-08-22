import ActivityKit
import WidgetKit
import SwiftUI

struct MyWalksWidgetsAndActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct MyWalksWidgetsAndActivityLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: MyWalksWidgetsAndActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension MyWalksWidgetsAndActivityAttributes {
    fileprivate static var preview: MyWalksWidgetsAndActivityAttributes {
        MyWalksWidgetsAndActivityAttributes(name: "World")
    }
}

extension MyWalksWidgetsAndActivityAttributes.ContentState {
    fileprivate static var smiley: MyWalksWidgetsAndActivityAttributes.ContentState {
        MyWalksWidgetsAndActivityAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: MyWalksWidgetsAndActivityAttributes.ContentState {
         MyWalksWidgetsAndActivityAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: MyWalksWidgetsAndActivityAttributes.preview) {
   MyWalksWidgetsAndActivityLiveActivity()
} contentStates: {
    MyWalksWidgetsAndActivityAttributes.ContentState.smiley
    MyWalksWidgetsAndActivityAttributes.ContentState.starEyes
}
