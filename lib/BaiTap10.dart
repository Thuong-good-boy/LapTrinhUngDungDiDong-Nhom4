import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:learn2110/api.dart';
import 'package:learn2110/model/product.dart';
import 'package:learn2110/services/constant.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  Map<String, dynamic>? paymentIntent;
  bool _isLoading = false; // Biến trạng thái loading

  @override
  void initState() {
    super.initState();
  }

  // --- HÀM THANH TOÁN (CODE SẠCH) ---
  // --- HÀM THANH TOÁN ĐÃ SỬA LỖI LẶP ---
  Future<void> makepayment(String amount) async {
    try {
      // 1. Reset sạch sẽ trước khi bắt đầu để tránh dùng lại key cũ
      paymentIntent = null;

      setState(() {
        _isLoading = true;
      });

      // 2. Tạo Payment Intent MỚI TINH (Dùng 'usd')
      paymentIntent = await createPaymentIntent(amount, 'usd');

      if (paymentIntent == null) {
        print("Lỗi: Không lấy được Key từ Stripe.");
        return;
      }

      // 3. Setup bảng thanh toán
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!["client_secret"],
            style: ThemeMode.light,
            merchantDisplayName: "ShopNew",
            // Thêm dòng này để xóa dữ liệu cũ nếu có
            appearance: const PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(primary: Colors.blue),
            ),
          ));

      // 4. Tắt Loading TRƯỚC khi hiện bảng (Quan trọng để tránh xung đột UI)
      setState(() {
        _isLoading = false;
      });

      // 5. Hiện bảng
      await displayPaymentSheet();

    } catch (e) {
      print("Lỗi quy trình: $e");
    } finally {
      // Đảm bảo tắt loading dù có lỗi hay không
      if (mounted && _isLoading) {
        setState(() { _isLoading = false; });
      }
    }
  }

  // Hàm hiển thị bảng UI (Đã sửa lỗi hiện 2 lần)
  Future<void> displayPaymentSheet() async {
    try {
      // Lệnh này sẽ chờ người dùng thanh toán xong mới chạy tiếp
      await Stripe.instance.presentPaymentSheet();

      // --- NẾU CODE CHẠY ĐẾN ĐÂY NGHĨA LÀ THANH TOÁN THÀNH CÔNG ---

      // Xóa ngay Key cũ đi để không bị lỗi "Already succeeded"
      paymentIntent = null;

      if (mounted) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green, size: 50),
                  SizedBox(height: 10),
                  Text("Thanh toán thành công!"),
                ],
              ),
            ));
      }
    } on StripeException catch (e) {
      // Nếu người dùng bấm dấu X hủy, hoặc lỗi thẻ, nó sẽ nhảy vào đây
      print("Thanh toán bị hủy hoặc lỗi: $e");
    } catch (e) {
      print("Lỗi hệ thống: $e");
    }
  }
  // Hàm gọi API Stripe
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card"
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": 'Bearer $Secretkey', // Chú ý: SecretKey (K viết hoa)
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print("Lỗi kết nối API Stripe: ${err.toString()}");
    }
  }

  // Hàm tính tiền (Chuyển đổi sang Cents)
  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }
  // --- KẾT THÚC LOGIC THANH TOÁN ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh Sách sản phẩm"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      // Dùng Stack để đè lớp Loading lên trên
      body: Stack(
        children: [
          // LỚP 1: Giao diện chính
          FutureBuilder<List<Product>>(
            future: test_api.getAllroduct(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.done) {
                if (snap.hasData) {
                  return myListVie(snap.data!);
                } else {
                  return const Center(child: Text("Không có dữ liệu"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),

          // LỚP 2: Màn hình Loading (Chỉ hiện khi _isLoading = true)
          if (_isLoading)
            Container(
              color: Colors.black54,
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget myListVie(List<Product> ls) {
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: ls.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return myItem(ls[index]);
      },
    );
  }

  Widget myItem(Product p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                p.image,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Thông tin chi tiết
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p.category.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${p.price}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      // NÚT MUA NGAY
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        // Khóa nút khi đang loading
                        onPressed: _isLoading
                            ? null
                            : () {
                          makepayment(p.price.toString());
                        },
                        child: const Text(
                          "Mua ngay",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}