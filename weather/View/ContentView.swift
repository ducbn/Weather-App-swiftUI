import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var listView: ListViewModel
    @ObservedObject var weather = ForecastViewModel()
    
    var body: some View {
        NavigationView {
            TabView{
                ForEach(listView.items) { item in
                    VStack {
                        VStack {
                            Text("\(item.nameCity)")
                                .font(.largeTitle)
                                .padding(.top)
                                .foregroundColor(.black)
                            
                            Text("\(Int(weather.forecast?.current.temp ?? 0))°C")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            
                            if let currentWeatherDescription = weather.forecast?.current.weather.first?.description {
                                Text("\(currentWeatherDescription)")
                                    .foregroundColor(.black)
                            }
                            
                        }

                        ScrollView {
                            if let forecast = weather.forecast {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 5) {
                                        ForEach(forecast.hourly.prefix(24), id: \.dt) { hour in
                                            VStack(alignment: .center) {
                                                Text("\(formatDate(from: hour.dt, with: "HH"))")
                                                    .foregroundColor(.white)
                                                
                                                if let icon = hour.weather.first?.icon {
                                                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) {image in image
                                                            .image?.resizable() //cho phép hình ảnh thay đổi kích thước.
                                                            .scaledToFit() // giữ nguyên tỷ lệ khung hình của hình ảnh và đảm bảo hình ảnh vừa với kích thước khung bạn đã đặt (.frame(width: 50, height: 50)).
                                                            .frame(width: 50, height: 50)
                                                    }
                                                }
                                                
                                                Text("\(Int(hour.temp))°C")
                                                    .font(.subheadline)
                                                    .foregroundColor(.white)
                                            }
                                            .padding()
                                        }
                                    }
                                    
                                }
                                .background(Color.gray.opacity(0.7))
                                .cornerRadius(20)
                                .padding()
                                
                                VStack {
                                    ForEach(forecast.daily.prefix(10), id: \.dt) { day in
                                        HStack {
                                            Text("\(formatDate(from: day.dt, with: "EEE"))")
                                                .foregroundColor(.white)
                                            Spacer()
                                            if let icon = day.weather.first?.icon {
                                                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")){img in img
                                                        .image?.resizable()
                                                        .scaledToFill()
                                                        .frame(width: 50, height: 50)
                                                }
                                            }
                                            Text("\(Int(day.temp.day)) °C")
                                                .foregroundColor(.white)
                                            
                                        }
                                        .padding()
                                        .cornerRadius(10)
                                    }
                                }
                                .background(Color.gray.opacity(0.7))
                                .cornerRadius(10)
                                .padding(.horizontal)

                            } else {
                                Text("Loading...!!!")
                                    .font(.largeTitle)
                                    .padding()
                            }
                        }
                    }
                    .onAppear {
                        weather.fetchForecast(latitude: item.lat, longitude: item.lon)
                    }
                            
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SearchLocation()) {
                        Image(systemName: "plus")
                    }
                }
        
            }
        }
    }
}

func formatDate(from timestamp: Int, with format: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

#Preview {
    ContentView()
        .environmentObject(ListViewModel())
}
