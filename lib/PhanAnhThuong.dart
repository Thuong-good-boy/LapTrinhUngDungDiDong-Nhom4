import 'package:flutter/material.dart';
// Import các bài tập của bạn
import 'package:learn2110/BaiTap1.dart';
import 'package:learn2110/BaiTap10.dart';
import 'package:learn2110/BaiTap11.dart';
import 'package:learn2110/BaiTap2.dart';
import 'package:learn2110/BaiTap3.dart';
import 'package:learn2110/BaiTap4.dart';
import 'package:learn2110/BaiTap5.dart';
import 'package:learn2110/BaiTap6.dart';
import 'package:learn2110/BaiTap7.dart';
import 'package:learn2110/BaiTap8.dart';
import 'package:learn2110/BaiTap9.dart';
import 'package:learn2110/PhanAnhThuongContent.dart';
import 'package:learn2110/PhanAnhThuongSideBar.dart';

// Map ánh xạ bài tập
final Map<String, Widget> assignmentWidgets = {
  'Bài Tập 01': const BaiTap1(),
  'Bài Tập 02': const BaiTap2(),
  'Bài Tập 03': const BaiTap3(),
  'Bài Tập 04': const BaiTap4(),
  'Bài Tập 05': const BaiTap5(),
  'Bài Tập 06': const BaiTap6(),
  'Bài Tập 07': const BaiTap7(),
  'Bài Tập 08': const BaiTap8(),
  'Bài Tập 09': const BaiTap9(),
  'Bài Tập 10': const MyProduct(),
  'Bài Tập 11': const ListTinTuc(),
  'Bài Tập 12': const BaiTap6(),
};

class Phananhthuong extends StatefulWidget {
  const Phananhthuong({super.key});

  @override
  State<Phananhthuong> createState() => _PhananhthuongState();
}

class _PhananhthuongState extends State<Phananhthuong> {
  // Mặc định là 'Trang Chủ'
  String _selectedAssignmentKey = 'Trang Chủ';

  void _selectAssignment(String key) {
    setState(() {
      _selectedAssignmentKey = key;
    });
    // Đóng Sidebar sau khi chọn
    Navigator.of(context).pop();
  }

  // Widget hiển thị nội dung
  Widget get _currentContent {
    if (_selectedAssignmentKey == 'Trang Chủ') {
      return const Phananhthuongcontent(assignmentName: 'Thông Tin Sinh Viên');
    }
    if (assignmentWidgets.containsKey(_selectedAssignmentKey)) {
      return assignmentWidgets[_selectedAssignmentKey]!;
    }
    return const Center(child: Text("Không tìm thấy nội dung"));
  }

  @override
  Widget build(BuildContext context) {
    // Biến kiểm tra xem có đang ở trang chủ không
    bool isHomePage = _selectedAssignmentKey == 'Trang Chủ';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isHomePage ? 'Bài Kiểm Tra Giữa Kì' : _selectedAssignmentKey,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,

        // --- PHẦN SỬA ĐỔI QUAN TRỌNG ---
        // Nếu là Trang Chủ: Để null -> Tự hiện nút Menu (3 gạch) để mở Sidebar
        // Nếu là Bài Tập: Hiện nút Mũi Tên -> Bấm vào quay về Trang Chủ
        leading: isHomePage
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _selectedAssignmentKey = 'Trang Chủ';
            });
          },
        ),
        // -------------------------------

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                // Text('Phan Anh Thương', style: TextStyle(fontSize: 14)), // Bỏ cmt nếu muốn hiện tên
                // SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('PA', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),

      // Sidebar (Drawer) vẫn giữ nguyên logic
      drawer: Drawer(
        width: 300,
        child: PhanAnhThuongSidebar(
          assignments: assignmentWidgets.keys.toList(),
          selectedKey: _selectedAssignmentKey,
          onSelect: _selectAssignment,
        ),
      ),

      body: Container(
        color: Colors.grey.shade50,
        child: _currentContent,
      ),
    );
  }
}