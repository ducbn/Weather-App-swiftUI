    import Foundation

    // Định nghĩa struct CityGeocodeResponse để ánh xạ dữ liệu JSON
    struct CityLocation: Identifiable, Codable{
        let id: String
        let lat: Double
        let lon: Double
        let name: String
        
        init(id: String = UUID().uuidString, lat: Double, lon: Double, name: String) {
            self.id = id
            self.lat = lat
            self.lon = lon
            self.name = name
        }
        
        func updatecompletion() -> CityLocation {
            return CityLocation(id: id, lat: lat, lon: lon, name: name)
        }
    }


    // Định nghĩa hàm fetchLocation với tham số cityName và một completion handler
    func fetchLocation(name: String, completion: @escaping (Double?, Double?) -> ()) {
        let apiKey = "bc806173965cb11b3b2d8245f42e2eab"
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(name)&limit=1&appid=\(apiKey)"
        
        
        guard let url = URL(string: urlString) else { // Tạo đối tượng URL từ chuỗi URL
            print("Invalid URL") // In ra thông báo nếu URL không hợp lệ
            completion(nil, nil) // Gọi completion với giá trị nil
            return // Kết thúc hàm
        }

        // Tạo một data task để gọi API
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error { // Kiểm tra xem có lỗi không
                print("Error fetching data: \(error.localizedDescription)") // In ra lỗi nếu có
                completion(nil, nil) // Gọi completion với giá trị nil
                return
            }
            
            guard let data = data else { // Kiểm tra xem có dữ liệu trả về không
                print("No data returned") // In ra thông báo nếu không có dữ liệu
                completion(nil, nil) // Gọi completion với giá trị nil
                return // Kết thúc hàm
            }

            do {
                let results = try JSONDecoder().decode([CityLocation].self, from: data)
                // Giải mã dữ liệu JSON thành một mảng CityGeocodeResponse
                
                guard let result = results.first else { // Lấy phần tử đầu tiên trong mảng
                    print("No results found") // In ra thông báo nếu không tìm thấy kết quả
                    completion(nil, nil) // Gọi completion với giá trị nil
                    return
                }
                let lat = result.lat // Lấy giá trị vĩ độ
                let lon = result.lon // Lấy giá trị kinh độ
                DispatchQueue.main.async { // Chuyển về luồng chính để cập nhật giao diện người dùng
                    completion(lat, lon) // Gọi completion với vĩ độ và kinh độ
                }
            } catch { // Bắt lỗi nếu quá trình giải mã thất bại
                print("Error decoding data: \(error.localizedDescription)") // In ra lỗi nếu có
                completion(nil, nil) // Gọi completion với giá trị nil
            }
        }.resume() // Bắt đầu task
    }

