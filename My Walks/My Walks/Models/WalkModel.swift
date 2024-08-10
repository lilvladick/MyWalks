import SwiftData
import CoreLocation

@Model
class Walk {
    let id = UUID()
    var name: String
    var walkDescription: String?
    var startPoint: String
    var endPoint: String
    var distance: Double
    var walkImage: Data?

    init(name: String, walkDescription: String? = nil, startPoint: String, endPoint: String, distance: Double, walkImage: Data? = nil) {
        self.name = name
        self.walkDescription = walkDescription
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.distance = distance
        self.walkImage = walkImage
    }
}
