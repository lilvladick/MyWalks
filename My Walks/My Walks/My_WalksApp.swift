import SwiftUI
import SwiftData

@main
struct My_WalksApp: App {
    let container: ModelContainer
    init() {
        do {
            container = try ModelContainer(for: Walk.self)
        } catch {
            fatalError("\(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            MainScreenView()
        }
        .modelContainer(container)
    }
}
