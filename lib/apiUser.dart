import 'package:dio/dio.dart';
import 'package:learn2110/model/user.dart';

class ApiUser {
  final Dio _dio = Dio();

  Future<User?> login(String username, String password) async {
    const String url = 'https://dummyjson.com/auth/login';

    try {

      Response response = await _dio.post(
        url,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {

        return User.fromJson(response.data);
      }

      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        print("Lỗi API: ${e.response?.data}");
      } else {
        print("Lỗi kết nối: ${e.message}");
      }
      return null;
    } catch (e) {
      print("Lỗi khác: $e");
      return null;
    }
  }
}

final apiService = ApiUser();