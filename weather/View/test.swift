import SwiftUI

struct TestListView: View {
    var body: some View {
        ScrollView(.horizontal) { // Thay đổi hướng cuộn thành ngang
            HStack(spacing: 0) { // Đổi VStack thành HStack để sắp xếp các phần tử theo chiều ngang
                ForEach(0..<20) { index in
                    Rectangle()
                        .overlay {
                            Text("\(index)")
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 200, alignment: .center) // Đặt chiều cao tối đa là vô hạn để chiếm toàn bộ chiều cao của màn hình
                        .containerRelativeFrame(.horizontal, alignment: .center) // Thay đổi khung để phù hợp với cuộn ngang
                }
            }
        }
        .ignoresSafeArea()
        .scrollTargetLayout()
        .scrollTargetBehavior(.paging)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    TestListView()
}
