import 'package:flutter/material.dart';
import 'package:learn2110/BaiTap6.dart';
import 'package:learn2110/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({super.key, required this.user});

  // --- HÀM XỬ LÝ ĐĂNG XUẤT ---
  void _handleLogout(BuildContext context) async {
    // Bước 1: Xóa token (Nếu bạn có dùng SharedPreferences để lưu đăng nhập)
    // Nếu chỉ truyền dữ liệu qua lại giữa các màn hình thì bước này có thể bỏ qua,
    // nhưng mình viết sẵn để sau này bạn dùng.
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token'); // Xóa token đã lưu
      await prefs.clear(); // Hoặc xóa sạch mọi thứ
    } catch (e) {
      print("Chưa cài SharedPreferences hoặc lỗi xóa cache: $e");
    }


    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BaiTap6()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin User"),
        backgroundColor: Colors.green,
        actions: [
          // Cách 1: Nút đăng xuất nhỏ trên góc phải
          IconButton(
            onPressed: () => _handleLogout(context),
            icon: const Icon(Icons.logout),
            tooltip: 'Đăng xuất',
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.image),
              radius: 50,
            ),
            const SizedBox(height: 20),
            Text("${user.firstName} ${user.lastName}",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(user.company.title, style: const TextStyle(color: Colors.grey)),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email"),
              subtitle: Text(user.email),
            ),


            const SizedBox(height: 30),

            // Cách 2: Nút Đăng xuất to rõ ràng ở dưới cùng
            SizedBox(
              width: double.infinity, // Full chiều ngang
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () => _handleLogout(context),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text("Đăng xuất",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent, // Màu đỏ cảnh báo
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Khoảng trắng dưới cùng
          ],
        ),
      ),
    );
  }
}