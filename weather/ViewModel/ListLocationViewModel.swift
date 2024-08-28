//
//  ListLocationModel.swift
//  weather
//
//  Created by Bùi ngọc Đức on 19/8/24.
//

import Foundation

class ListLocationViewModel:ObservableObject{
    @Published var items: [CityLocation] = []{
        didSet{
            saveItem()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init (){
        getItem()
    }
     
    func getItem(){
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let saveItems = try? JSONDecoder().decode([CityLocation].self, from: data)
        else { return }
        self.items = saveItems
    }
    
    func saveItem(){
        if let encodeedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodeedData, forKey: itemsKey)
        }
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func addItem(lat: Double, lon: Double, nameCity: String){
        let newItem = CityLocation(lat: lat, lon: lon, name: nameCity)
        items.append(newItem)
    }
    
//    func updateItem(item: CityLocation){
//        if let index = items.firstIndex(where: {$0.id == item.id}){
//            items[index] = item.updatecompletion()
//        }
//    }
    
}
