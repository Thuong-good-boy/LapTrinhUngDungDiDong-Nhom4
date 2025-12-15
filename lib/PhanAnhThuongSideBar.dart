import 'package:flutter/material.dart';

class PhanAnhThuongSidebar extends StatelessWidget {
  final List<String> assignments;
  final String selectedKey;
  final Function(String) onSelect;

  const PhanAnhThuongSidebar({
    super.key,
    required this.assignments,
    required this.selectedKey,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Màu sắc dựa trên giao diện
    final Color backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final Color selectedItemColor = Colors.blue;
    final Color unselectedItemColor = isDarkMode ? Colors.white70 : Colors.black87;
    final Color selectedTileColor = isDarkMode ? Colors.blue.withOpacity(0.2) : Colors.blue.shade50;

    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            color: Colors.blue.shade800,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    "PA",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Phan Anh Thương",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "MSSV: 22T1020756",
                  style: TextStyle(
                    color: Colors.blue.shade100,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: selectedKey == 'Trang Chủ' ? selectedItemColor : unselectedItemColor,
                  ),
                  title: Text(
                    "Trang Chủ",
                    style: TextStyle(
                      fontWeight: selectedKey == 'Trang Chủ' ? FontWeight.bold : FontWeight.normal,
                      color: selectedKey == 'Trang Chủ' ? selectedItemColor : textColor,
                    ),
                  ),
                  tileColor: selectedKey == 'Trang Chủ' ? selectedTileColor : null,
                  onTap: () => onSelect('Trang Chủ'),
                ),
                const Divider(),
                ...assignments.map((key) {
                  final isSelected = key == selectedKey;
                  return ListTile(
                    leading: Icon(
                      Icons.assignment,
                      color: isSelected ? selectedItemColor : unselectedItemColor,
                    ),
                    title: Text(
                      key,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? selectedItemColor : textColor,
                      ),
                    ),
                    tileColor: isSelected ? selectedTileColor : null,
                    onTap: () => onSelect(key),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}