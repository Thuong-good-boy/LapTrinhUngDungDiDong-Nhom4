import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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

  bool _isSending = false;

  // --- HÀM GỬI EMAIL ---
  Future<void> sendEmail() async {
    // ⚠️ LƯU Ý BẢO MẬT: Nhớ xóa mật khẩu trước khi đưa lên GitHub
    String username = '';
    String password = '';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'App Feedback')
      ..recipients.add(username)
      ..subject = '📝 Phản hồi mới: ${_nameController.text}'
      ..text = '''
      Người gửi: ${_nameController.text}
      Đánh giá: $_selectedRating ⭐
      ---------------------------
      Nội dung:
      ${_contentController.text}
      ''';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());

      if (mounted) {
        // Hiện Dialog đẹp hơn
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Column(
              children: const [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 10),
                Text("Thành công!", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            content: const Text(
              "Cảm ơn bạn đã đóng góp ý kiến cho chúng tôi.",
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _nameController.clear();
                    _contentController.clear();
                    setState(() {
                      _selectedRating = null;
                    });
                  },
                  child: const Text("Tuyệt vời", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        );
      }
    } catch (e) {
      print('Lỗi gửi mail: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(children: [const Icon(Icons.error, color: Colors.white), const SizedBox(width: 10), Expanded(child: Text("Lỗi: $e"))]),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _submitFeedback() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isSending = true; });
      await sendEmail();
      if (mounted) { setState(() { _isSending = false; }); }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Màu nền xám nhẹ cho sang
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Gửi Phản Hồi", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF9966), Color(0xFFFF5E62)], // Gradient Cam - Đỏ
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Icon
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mark_email_unread_outlined, size: 80, color: Color(0xFFFF5E62)),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Chúng tôi lắng nghe bạn",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Hãy chia sẻ ý kiến để chúng tôi phục vụ tốt hơn",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // INPUT: HỌ TÊN
                _buildModernTextField(
                  controller: _nameController,
                  label: "Họ và tên",
                  icon: Icons.person_outline,
                  validator: (v) => v!.isEmpty ? "Vui lòng nhập tên" : null,
                ),
                const SizedBox(height: 20),

                // INPUT: ĐÁNH GIÁ (DROPDOWN)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: DropdownButtonFormField<int>(
                    value: _selectedRating,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.star_outline, color: Colors.orange),
                      labelText: "Bạn đánh giá mấy sao?",
                    ),
                    items: [1, 2, 3, 4, 5].map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Row(
                          children: [
                            Text("$value", style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 5),
                            const Icon(Icons.star, color: Colors.amber, size: 20),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _selectedRating = val),
                    validator: (v) => v == null ? "Vui lòng chọn sao" : null,
                  ),
                ),
                const SizedBox(height: 20),

                // INPUT: NỘI DUNG
                _buildModernTextField(
                  controller: _contentController,
                  label: "Nội dung góp ý",
                  icon: Icons.edit_note,
                  maxLines: 5,
                  validator: (v) => v!.isEmpty ? "Vui lòng nhập nội dung" : null,
                ),
                const SizedBox(height: 35),

                // BUTTON GỬI
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9966), Color(0xFFFF5E62)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF5E62).withOpacity(0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isSending ? null : _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: _isSending
                        ? const SizedBox(width: 25, height: 25, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Gửi Ngay", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(width: 10),
                        Icon(Icons.send_rounded, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget con để tái sử dụng Text Field cho đẹp
  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.orange), // Icon màu cam
          border: InputBorder.none, // Bỏ viền đen mặc định
          contentPadding: const EdgeInsets.all(20),
          focusedBorder: OutlineInputBorder( // Viền khi bấm vào
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.orangeAccent, width: 1.5),
          ),
          errorBorder: OutlineInputBorder( // Viền khi lỗi
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
        ),
      ),
    );
  }
}