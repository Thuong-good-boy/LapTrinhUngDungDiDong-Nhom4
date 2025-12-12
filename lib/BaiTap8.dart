import 'package:flutter/material.dart';
class BaiTap8 extends StatefulWidget {
  const BaiTap8({super.key});

  @override
  State<BaiTap8> createState() => _BaiTap8State();
}

class _BaiTap8State extends State<BaiTap8> {
  final  heightController = TextEditingController();
  final  weightController = TextEditingController();
  double? bmi;
  String classfication="";
  final _formKey = GlobalKey<FormState>();
  void _calculateBMI() {
    if (_formKey.currentState!.validate()) {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);

      double result = weight / (height * height);

      String type = "";
      if (result < 18.5) {
        type = "Thiếu cân";
      } else if (result >= 18.5 && result <= 24.9) {
        type = "Bình thường";
      } else if (result >= 25 && result <= 29.9) {
        type = "Thừa cân";
      } else {
        type = "Béo phì";
      }

      setState(() {
        bmi = result;
        classfication = type;
      });

      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Tính chỉ số BMI"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.height),
                  labelText: "Chiều cao (m)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập chiều cao";
                  }
                  if (double.tryParse(value) == null) {
                    return "Chiều cao phải là số";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(
                  labelText: "Cân nặng (kg)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.monitor_weight_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Vui lòng nhập cân nặng";
                  }
                  if (double.tryParse(value) == null) {
                    return "Cân nặng phải là số";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: _calculateBMI,
                icon: const Icon(Icons.calculate),
                label: const Text("Tính BMI"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF148776),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),

              const SizedBox(height: 20),
              if (bmi != null)...[
                Text(
                  "Chỉ số BMI: ${bmi!.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Phân loại: $classfication",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
