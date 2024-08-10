import SwiftUI
import SwiftData

struct WalkListView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @AppStorage("isDarkModeOn") private var isDarkmodeOn = false
    @Query var walks: [Walk]
    @State private var searchText = ""
    var filterWalks: [Walk] {
        guard !searchText.isEmpty else { return walks }
        
        return walks.filter({ $0.name.localizedCaseInsensitiveContains(searchText) })
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filterWalks, id: \.id) { walk in
                    NavigationLink(destination: WalkDetailsView()) {
                        WalkRowView(walk: walk)
                    }
                    .tint(isDarkmodeOn ? Color.white : Color.black)
                }
                .onDelete(perform: deleteWalk)
            }
            .navigationTitle("Saved walks")
            .searchable(text: $searchText)
            .overlay {
                if filterWalks.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
        }
        .preferredColorScheme(isDarkmodeOn ? .dark : .light)
    }
    
    func deleteWalk(at offsets: IndexSet) {
        for index in offsets {
            let walk = walks[index]
            modelContext.delete(walk)
        }
        
        do {
            try modelContext.save()
        } catch {
            print(error)
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Walk.self)
    let modelContext = container.mainContext
    /*
    let walks = [
        Walk(name: "City walk", walkDescription: "my first walk", startPoint: "Arbat st.", endPoint: "Tverskoy av.", distance: 4.2, walkImage: nil),
        Walk(name: "Town walk", walkDescription: "my second walk", startPoint: "Arbat st.", endPoint: "Tverskoy av.", distance: 4.2, walkImage: nil)
    ]
    
    walks.forEach { modelContext.insert($0) } */
    
    return WalkListView().modelContainer(container)
}
