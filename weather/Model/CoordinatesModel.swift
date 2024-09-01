import Foundation

struct CoordinatesModel: Identifiable, Codable{
    let id = UUID()
    let nameCity: String
    let lat: Double
    let lon: Double
    
    init(nameCity: String, lat: Double, lon: Double) {
        self.nameCity = nameCity
        self.lat = lat
        self.lon = lon
    }
}

