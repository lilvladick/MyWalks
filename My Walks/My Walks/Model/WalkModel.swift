import SwiftData
import Foundation

@Model
final class Walk {
    let id = UUID()
    var name: String
    var date: Date
    var distance: Double
    // Variable for saving the route
    
    init(name: String, date: Date, distance: Double) {
        self.name = name
        self.date = date
        self.distance = distance
    }
}
