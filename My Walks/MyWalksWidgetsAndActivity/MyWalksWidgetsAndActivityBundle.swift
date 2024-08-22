import WidgetKit
import SwiftUI

@main
struct MyWalksWidgetsAndActivityBundle: WidgetBundle {
    var body: some Widget {
        MyWalksWidgetsAndActivity()
        MyWalksWidgetsAndActivityLiveActivity()
    }
}
