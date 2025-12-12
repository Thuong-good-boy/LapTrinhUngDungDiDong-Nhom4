import 'package:flutter/material.dart';
class BaiTap7 extends StatefulWidget {
  const BaiTap7({super.key});

  @override
  State<BaiTap7> createState() => _BaiTap7State();
}

class _BaiTap7State extends State<BaiTap7> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _password = true;
  bool _passwordConfirm = true;

  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Form Đăng Ký")),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        margin:  EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                      decoration: InputDecoration(
                        labelText: "Họ tên",
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
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        )
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      if (!value.contains('@')) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0,),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _password,
                    decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(icon:
                        _password ? Icon(Icons.visibility) : Icon(Icons
                            .visibility_off)
                            , onPressed: () {
                              setState(() {
                                _password = !_password;
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
                  TextFormField(
                    obscureText: _passwordConfirm,
                    decoration: InputDecoration(
                        labelText: "Xác nhận mật khẩu",
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            _passwordConfirm =!_passwordConfirm;
                          });
                        },
                            icon: _passwordConfirm
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)
                        )
                    ),
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng xác nhận mật khẩu';
                      }
                      if (value != _passwordController.text) {
                        return 'Mật khẩu không khớp';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.0,),
                  Container(
                    width: 200,
                    height: 50.0,
                    child: ElevatedButton(onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Đăng ký thành công",
                              style: TextStyle(color: Colors.greenAccent),)));
                      }
                    }, style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )
                    )
                        , child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.login, color: Colors.white,),
                            SizedBox(width: 8.0,),
                            Text("Đăng ký", style: TextStyle(
                                color: Colors.white, fontSize: 16),),

                          ],
                        )),
                  )
                ],
              )),

        ),
      ),
    );
  }
}
