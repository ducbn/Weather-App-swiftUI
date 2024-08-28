//
//  ListRowLoaction.swift
//  weather
//
//  Created by Bùi ngọc Đức on 22/8/24.
//

import SwiftUI

struct ListRowLocation: View {
    let item: CityLocation
    @ObservedObject var itemWeather = ForecastViewModel()
    
    var body: some View {
        ZStack{
            Image("sunday")
                .resizable()
                .frame(height: 120)
                .padding()
                .cornerRadius(20)
            
            HStack{
                Text(item.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.trailing, 100)
                
                Text("\(Int(itemWeather.forecast?.current.temp ?? 0))°C")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .onAppear {
                itemWeather.fetchForecast(latitude: item.lat, longitude: item.lon)
            }
            
        }
        .frame(width: 400, height: 120)
        
    }
}

struct ListRowLocation_Previews: PreviewProvider{
    static var item1 = CityLocation(lat: 0, lon: 0, name: "Ha noi")
    
    static var previews: some View{
        Group{
            ListRowLocation(item: item1)
        }
        .previewLayout(.sizeThatFits)
    }
}
