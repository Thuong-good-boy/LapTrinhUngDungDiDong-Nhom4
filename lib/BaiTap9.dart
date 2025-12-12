import 'package:flutter/material.dart';
class BaiTap9 extends StatefulWidget {
  const BaiTap9({super.key});

  @override
  State<BaiTap9> createState() => _BaiTap9State();
}

class _BaiTap9State extends State<BaiTap9> {
  final _nameController = TextEditingController();
  final _contentController = TextEditingController();

  int? _selectedRating;

  final _formKey = GlobalKey<FormState>();
  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("Thành công!"),
              content: Text(
                "Cảm ơn ${_nameController
                    .text} đã đánh giá $_selectedRating sao.\n\nNội dung: ${_contentController
                    .text}",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Đóng"),
                )
              ],
            ),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Center(child: Text("Gửi phản hồi",style: TextStyle(color: Colors.white),)),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body:
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Họ tên",
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập họ tên";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<int>(
                    value: _selectedRating,
                    decoration: InputDecoration(
                      labelText: "Đánh giá (1 - 5 sao)",
                      prefixIcon: const Icon(Icons.star),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      isDense: true,
                    ),
                    items: [1, 2, 3, 4, 5].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text("$value sao"),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedRating = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Vui lòng chọn số sao";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _contentController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Nội dung góp ý",
                      alignLabelWithHint: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: Icon(Icons.feedback_outlined),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập nội dung góp ý";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _submitFeedback,
                      icon: const Icon(Icons.send),
                      label: const Text("Gửi phản hồi"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}
