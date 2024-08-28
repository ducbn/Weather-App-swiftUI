import Foundation

class ForecastViewModel: ObservableObject {
    @Published var forecast: Forecast?
    let apiKey = "bc806173965cb11b3b2d8245f42e2eab"
    let baseURL = "https://api.openweathermap.org/data/3.0/onecall"

    func fetchForecast(latitude: Double, longitude: Double) {
        guard let url = URL(string: "\(baseURL)?lat=\(latitude)&lon=\(longitude)&exclude=minutely,alerts&appid=\(apiKey)&units=metric") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                    DispatchQueue.main.async {
                        self.forecast = forecast
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}
