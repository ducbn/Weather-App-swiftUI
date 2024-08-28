import Foundation

struct Forecast: Codable {
    // Hiện tại
    struct Current: Codable {
        let dt: Int // timestamp ngày tháng
        let sunrise: Int // mặt trời mọc
        let sunset: Int // mặt trời lặn
        let temp: Double // nhiệt độ
        let humidity: Int // độ ẩm
        let clouds: Int // mây
        struct Weather: Codable {
            let id: Int
            let description: String // mô tả thời tiết
            let icon: String
        }
        let weather: [Weather]
    }
    let current: Current
    
    // Theo giờ
    struct Hourly: Codable {
        let dt: Int // timestamp ngày tháng
        let temp: Double // nhiệt độ
        struct Weather: Codable {
            let id: Int
            let icon: String
        }
        let weather: [Weather]
    }
    let hourly: [Hourly]
    
    // Hàng ngày
    struct Daily: Codable {
        let dt: Int // timestamp ngày
        struct Temp: Codable {
            let day: Double
        }
        let temp: Temp
        struct Weather: Codable {
            let id: Int
            let icon: String
        }
        let weather: [Weather]
        let clouds: Int // mây
        let rain: Double?
    }
    let daily: [Daily]
}
