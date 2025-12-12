import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:learn2110/model/product.dart';
import 'package:learn2110/model/tinTuc.dart';

class API {
  Future<List<Product>> getAllroduct() async {
    var dio = Dio();
    var url = 'https://fakestoreapi.com/products';

    try {
      var response = await dio.get(url);
      List<Product> ls = [];

      if (response.statusCode == 200) {
        List data = response.data;
        ls = data.map((json) => Product.fromJson(json)).toList();
      }
      return ls;
    } catch (e) {
      print("Lỗi: $e");
      return [];
    }
  }
  Future<List<Article>> getTinnTucAll() async{
      var dio= Dio();
      var url= 'https://gnews.io/api/v4/top-headlines?category=general&lang=vi&country=vn&apikey=f34db10a5cc12aac63aab8654d3f7e22';
      try {
        var response = await dio.get(url);
        List<tinTuc> ls = [];
        if (response.statusCode == 200) {
          tinTuc dataWrapper = tinTuc.fromJson(response.data);

          // 2. Trả về danh sách bài viết bên trong
          return dataWrapper.articles;
        }
        return [];
      }catch (e) {
        print("Lỗi: $e");
        return [];
      }

      }

  }

var test_api= API();