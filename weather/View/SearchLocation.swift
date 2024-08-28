import SwiftUI

struct SearchLocation: View {
    @State private var cityName: String = ""
    @State private var latitude: Double?
    @State private var longitude: Double?
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Nhập tên thành phố", text: $cityName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    isLoading = true
                    fetchLocation(name: cityName) { lat, lon in
                        if let lat = lat, let lon = lon {
                            self.latitude = lat
                            self.longitude = lon
                        } else {
                            print("Error: Could not fetch location.")
                            // Bạn có thể xử lý lỗi ở đây, ví dụ như hiển thị thông báo lỗi cho người dùng.
                        }
                        isLoading = false
                    }

                }) {
                    Text("Tìm kiếm")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                if isLoading {
                    ProgressView()
                } else if let lat = latitude, let lon = longitude {
                    Text("Vĩ độ: \(lat)")
                    Text("Kinh độ: \(lon)")
                } else if cityName != "" {
                    Text("Không tìm thấy thành phố")
                }
            }
            .padding()
            .navigationTitle("Tìm kiếm địa điểm") // Thêm tiêu đề cho NavigationView
        }
    }
}

#Preview {
    SearchLocation()
}
