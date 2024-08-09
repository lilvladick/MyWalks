import SwiftData
import CoreLocation

@Model
class Walk {
    var id: UUID
    var name: String
    var walkDescription: String?
    //var coordinates: [Coordinate]
    //var startPoint: Coordinate
   // var endPoint: Coordinate
    var walkImage: Data?

    init(id: UUID, name: String, walkDescription: String? = nil, walkImage: Data? = nil) {
        self.id = id
        self.name = name
        self.walkDescription = walkDescription
        self.walkImage = walkImage
    }
}
