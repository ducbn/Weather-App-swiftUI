//
//  ListRowLoaction.swift
//  weather
//
//  Created by Bùi ngọc Đức on 22/8/24.
//

import SwiftUI

struct ListRowLocation: View {
    let item: CoordinatesModel
    @ObservedObject var itemWeather = ForecastViewModel()
    
    var body: some View {
        HStack{
            VStack{
                Text(item.nameCity)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.bottom, 2)
                
                Text("\(Int(itemWeather.forecast?.current.temp ?? 0))°C")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            
            VStack{
                if let icon = itemWeather.forecast?.current.weather.first?.icon {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")) {image in image
                            .image?.resizable() //cho phép hình ảnh thay đổi kích thước.
                            .scaledToFit() // giữ nguyên tỷ lệ khung hình của hình ảnh và đảm bảo hình ảnh vừa với kích thước khung bạn đã đặt (.frame(width: 50, height: 50)).
                            .frame(width: 50, height: 50)
                    }
                }
                
                HStack{
                    Text("H: \(Int(itemWeather.forecast?.current.humidity ?? 0))")
                    Text("C: \(Int(itemWeather.forecast?.current.clouds ?? 0))")
                }
            }
        }
        .onAppear {
            itemWeather.fetchForecast(latitude: item.lat, longitude: item.lon)
        }
        .padding(10)
        
    }
}

struct ListRowLocation_Previews: PreviewProvider{
    static var item1 = CoordinatesModel(nameCity: "Hải Dương", lat: 0, lon: 0)
    
    static var previews: some View{
        Group{
            ListRowLocation(item: item1)
        }
        .previewLayout(.sizeThatFits)
    }
}
