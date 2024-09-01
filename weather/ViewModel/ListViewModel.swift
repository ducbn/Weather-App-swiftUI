//
//  ListLocationModel.swift
//  weather
//
//  Created by Bùi ngọc Đức on 19/8/24.
//
import Foundation

class ListViewModel : ObservableObject{
    
    @Published var items: [CoordinatesModel] = []{
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
            let saveItems = try? JSONDecoder().decode([CoordinatesModel].self, from: data)
        else { return }
        self.items = saveItems
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(name: String, lat: Double, lon: Double){
        let newItem = CoordinatesModel(nameCity: name, lat: lat, lon: lon)
        items.append(newItem)
    }
    
    func saveItem(){
        if let encodeedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodeedData, forKey: itemsKey)
        }
    }
}

