import 'package:flutter/material.dart';

class BaiTap2 extends StatefulWidget {
  const BaiTap2({super.key});

  @override
  State<BaiTap2> createState() => _BaiTap2State();
}

class _BaiTap2State extends State<BaiTap2> {
  List anh = [
    "assets/images/laudai.jpg",
    "assets/images/nhatho.jpg",
    "assets/images/nhatho2.jpg",
    "assets/images/nhatho3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Thêm màu nền trắng cho sạch sẽ
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25.0), // Tăng padding chút cho thoáng
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái chuẩn hơn
              children: [
                // --- Header (Giữ nguyên Icon) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0), // Chỉnh lại margin cho cân
                      decoration: BoxDecoration(
                        color: Colors.grey[100], // Thêm nền nhẹ cho nút bấm đẹp hơn
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.notifications, size: 28.0),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5, right: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.extension, size: 28.0),
                    ),
                  ],
                ),

                const SizedBox(height: 30.0), // Tăng khoảng cách cho thoáng

                // --- Welcome Text (Giữ nguyên nội dung) ---
                Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 45.0, height: 1.2),
                      children: [
                        TextSpan(
                          text: "Welcome,\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "Charlie",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black54 // Làm nhạt tên đi 1 xíu cho có chiều sâu
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30.0),

                // --- Search Bar (Giữ nguyên viền xanh) ---
                SizedBox( // Dùng SizedBox thay Container width MediaQuery (Code gọn hơn)
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(fontSize: 18.0, color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      // Giữ nguyên viền xanh như ý bạn
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0), // Bo cong mềm hơn xíu
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40.0),

                // --- Title Saved Places ---
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Saved Places",
                      style: TextStyle(
                        fontSize: 22.0, // Tăng size lên xíu cho rõ
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20.0),

                // --- GridView (Giữ nguyên ảnh) ---
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), // Quan trọng: Không cho Grid tự cuộn để tránh xung đột
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1, // FIX LỖI 2: Chỉnh tỉ lệ để ảnh không bị bẹt (1.5 cũ làm ảnh bị lùn)
                    mainAxisSpacing: 15,   // Tăng khoảng cách cho thoáng
                    crossAxisSpacing: 15,
                  ),
                  itemCount: anh.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [ // Thêm đổ bóng nhẹ cho ảnh nổi lên
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          anh[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
                // Thêm khoảng trống dưới cùng để lướt không bị cấn
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}