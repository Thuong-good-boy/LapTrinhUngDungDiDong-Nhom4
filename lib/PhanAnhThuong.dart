import 'package:flutter/material.dart';
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
import 'package:learn2110/Place.dart';
import 'package:learn2110/my_home_page.dart';
import 'package:learn2110/theme.dart';

final Map<String, Widget> assignmentWidgets = {
  'Bài tập 01': const MyHomePage(),
  'Bài tập 02': const MyPlace(),
  'Bài Tập 03': const BaiTap1(),
  'Bài Tập 04': const BaiTap2(),
  'Bài Tập 05': const BaiTap3(),
  'Bài Tập 06': const BaiTap4(),
  'Bài Tập 07': const BaiTap5(),
  'Bài Tập 08': const BaiTap6(),
  'Bài Tập 09': const BaiTap7(),
  'Bài Tập 10': const BaiTap8(),
  'Bài Tập 11': const BaiTap9(),
  'Bài Tập 12': const MyProduct(),
  'Bài Tập 13': const ListTinTuc(),
  'Bài Tập 14': const BaiTap6(),
};

class Phananhthuong extends StatefulWidget {
  const Phananhthuong({super.key});

  @override
  State<Phananhthuong> createState() => _PhananhthuongState();
}

class _PhananhthuongState extends State<Phananhthuong> {
  String _selectedAssignmentKey = 'Trang Chủ';

  void _selectAssignment(String key) {
    setState(() {
      _selectedAssignmentKey = key;
    });
    Navigator.of(context).pop();
  }

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
    bool isHomePage = _selectedAssignmentKey == 'Trang Chủ';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isHomePage ? 'Bài Kiểm Tra Giữa Kì' : _selectedAssignmentKey,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
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
        actions: [
          IconButton(
            onPressed: () {
              ThemeManager.toggleTheme();
            },
            icon: ValueListenableBuilder<ThemeMode>(
              valueListenable: ThemeManager.themeNotifier,
              builder: (_, mode, __) {
                return Icon(
                  mode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                  color: Colors.white,
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20.0, left: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('PA', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        width: 300,
        child: PhanAnhThuongSidebar(
          assignments: assignmentWidgets.keys.toList(),
          selectedKey: _selectedAssignmentKey,
          onSelect: _selectAssignment,
        ),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: _currentContent,
      ),
    );
  }
}