import 'package:flutter/material.dart';
import 'package:learn2110/BaiTap1.dart';
import 'package:learn2110/BaiTap2.dart';
import 'package:learn2110/BaiTap3.dart';
import 'package:learn2110/BaiTap4.dart';
import 'package:learn2110/BaiTap5.dart';
import 'package:learn2110/BaiTap6.dart';
import 'package:learn2110/BaiTap7.dart';
import 'package:learn2110/BaiTap8.dart';
import 'package:learn2110/BaiTap9.dart';
import 'package:learn2110/BaiTap10.dart';
import 'package:learn2110/BaiTap11.dart';
import 'package:learn2110/PhanAnhThuong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

      ),
      debugShowCheckedModeBanner: false,
      home: Phananhthuong(),
    );
  }
}

