import 'package:flutter/material.dart';

class Phananhthuongcontent extends StatelessWidget {
  final String assignmentName;

  const Phananhthuongcontent({super.key, required this.assignmentName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Kéo dãn full chiều ngang
        children: [
          // Card thông tin chính
          Card(
            elevation: 4, // Đổ bóng
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Icon(Icons.school, size: 60, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    assignmentName, // 'Thông Tin Sinh Viên'
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A)
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildRowInfo("Họ và Tên:", "Phan Anh Thương"),
                  _buildRowInfo("Mã Sinh Viên:", "22T1020756"),
                  _buildRowInfo("Lớp/Nhóm:", "Nhóm 4"),
                  _buildRowInfo("Giảng Viên:", "ThS. Nguyễn Dũng"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),


        ],
      ),
    );
  }

  Widget _buildRowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}