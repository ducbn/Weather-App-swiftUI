import SwiftUI

struct SearchLocation: View {
    @State private var cityName: String = ""
    @State private var latitude: Double?
    @State private var longitude: Double?
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("type your city here...", text: $cityName)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Button(action: saveButton) {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                
                if listViewModel.items.isEmpty{
                    Text("Please type your location!!")
                }else{
                    List{
                        ForEach(listViewModel.items) { item in
                            ListRowLocation(item: item)
                        }
                        .onDelete(perform: listViewModel.deleteItem)
                    }
                }
            }
            .padding(14)
        }
        .navigationTitle("Search for location")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
    }
    
    func saveButton() {
        if textIsAppropriate() == true{
            fetchLocation(name: cityName) { lat, lon in
                if let lat = lat, let lon = lon {
                    print("Found location: lat = \(lat), lon = \(lon)")
                    self.latitude = lat
                    self.longitude = lon
                    listViewModel.addItem(name: cityName, lat: lat, lon: lon)
                    print("Item count after addition: \(listViewModel.items.count)")
                    presentationMode.wrappedValue.dismiss()
                } else {
                    print("Location not found")
                    alertTitle = "No location found for the city entered"
                    showAlert.toggle()
                }
            }
        }
    }

    
    func textIsAppropriate() -> Bool{
        if cityName.count < 1{
            alertTitle =  "Please, you need to enter your city name"
            showAlert.toggle()
            return false
        }
        return true
    }
}

struct SearchLocation_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchLocation()
                .environmentObject(ListViewModel())
        }
    }
}
