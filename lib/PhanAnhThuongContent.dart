import 'package:flutter/material.dart';

class Phananhthuongcontent extends StatelessWidget {
  final String assignmentName;

  const Phananhthuongcontent({super.key, required this.assignmentName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Phần tiêu đề Assignment (nếu cần hiển thị riêng)
          Text(
            assignmentName.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // --- CARD THÔNG TIN SINH VIÊN (STYLE MỚI) ---
          Card(
            elevation: 8, // Bóng đổ sâu hơn tạo độ nổi
            shadowColor: Colors.blueAccent.withOpacity(0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias, // Để cắt background gradient bo góc
            child: Column(
              children: [
                // 1. Phần Header của Card (Gradient + Avatar)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)], // Xanh dương gradient
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Avatar (Hình tròn)
                      Container(
                        padding: const EdgeInsets.all(4), // Viền trắng
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Color(0xFFE3F2FD),
                          // Nếu có ảnh thì dùng NetworkImage, ở đây dùng Icon thay thế
                          child: Icon(Icons.person, size: 50, color: Color(0xFF2193b0)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Tên Sinh Viên
                      const Text(
                        "Phan Anh Thương",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      // Chức vụ / Vai trò
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Sinh Viên K46",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Phần thông tin chi tiết
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _buildModernRow(Icons.badge, "Mã Sinh Viên", "22T1020756"),
                      const Divider(height: 25, thickness: 0.5),

                      _buildModernRow(Icons.groups, "Nhóm Lớp", "Nhóm 4"),
                      const Divider(height: 25, thickness: 0.5),

                      _buildModernRow(Icons.email, "Email HUSC", "22T1020756@husc.edu", isLink: true),
                      const Divider(height: 25, thickness: 0.5),

                      _buildModernRow(Icons.supervisor_account, "Giảng Viên HD", "ThS. Nguyễn Dũng"),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị dòng thông tin kiểu mới
  Widget _buildModernRow(IconData icon, String label, String value, {bool isLink = false}) {
    return Row(
      children: [
        // Icon bên trái
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF2193b0), size: 22),
        ),
        const SizedBox(width: 15),

        // Nội dung text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  color: isLink ? Colors.blue[700] : Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  decoration: isLink ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}