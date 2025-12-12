import 'dart:math';

import 'package:flutter/material.dart';
class BaiTap5 extends StatefulWidget {
  const BaiTap5({super.key});

  @override
  State<BaiTap5> createState() => _BaiTap5State();
}

class _BaiTap5State extends State<BaiTap5> {
  Color bgColor= Colors.purple;
  String text= "purple";
  List<Color> listColors=[
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];
  List<String>listColorString = [
    'blue','red','green','pink'
  ];
  void _changeColor(){
    var rand= Random();
    var numberRanhdom= rand.nextInt(listColors.length);
    setState(() {
      bgColor = listColors[numberRanhdom];
      text = listColorString[numberRanhdom];
    });
  }
  Widget myBody(){
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
      ),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: [
          Text("Current Color"),
          Text(text),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed:_changeColor , child: Text("Change Color")),
              ElevatedButton(onPressed: (){
                setState(() {
                  bgColor=Colors.purple;

                });
              } , child: Text("Reset"))
            ],
          )
        ],
      ),

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Ứng dụng Đổi màu nền")),
          backgroundColor: Colors.green,
        ),
        body:
        myBody()
    );
  }
}
