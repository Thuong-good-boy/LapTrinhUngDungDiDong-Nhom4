import 'package:flutter/material.dart';
import 'package:learn2110/Home.dart';
import 'package:learn2110/apiUser.dart';
import 'package:learn2110/model/user.dart';
class BaiTap6 extends StatefulWidget {
  const BaiTap6({super.key});

  @override
  State<BaiTap6> createState() => _BaiTap6State();
}

class _BaiTap6State extends State<BaiTap6> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      User? user = await apiService.login(
          _userController.text,
          _passController.text
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Chào mừng ${user.firstName} ${user.lastName}!"),
          backgroundColor: Colors.green,
        ));

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => UserProfileScreen(user: user)
        ));

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Đăng nhập thất bại. Vui lòng kiểm tra lại!"),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Form Đăng Nhập")),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // --- USERNAME ---
                    TextFormField(
                        controller: _userController,
                        decoration: InputDecoration(
                          labelText: "Tên Người dùng",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập tên người dùng";
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 30.0,),

                    // --- PASSWORD ---
                    TextFormField(
                      controller: _passController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                          labelText: "Mật khẩu",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          suffixIcon: IconButton(icon:
                          _obscurePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              })
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải ít nhất 6 ký tự';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30.0),

                    Container(
                      width: 200,
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              )
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.login, color: Colors.white,),
                              SizedBox(width: 8.0,),
                              Text("Đăng Nhập", style: TextStyle(
                                  color: Colors.white, fontSize: 16),),
                            ],
                          )
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
