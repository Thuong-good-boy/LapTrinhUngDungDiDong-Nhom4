import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn2110/NewsDetailPage.dart';
import 'package:learn2110/api.dart';
import 'package:learn2110/model/tinTuc.dart';

class ListTinTuc extends StatefulWidget {
  const ListTinTuc({super.key});

  @override
  State<ListTinTuc> createState() => _ListTinTucState();
}

class _ListTinTucState extends State<ListTinTuc> {
  final API _api = API();

  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = _api.getTinnTucAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Tin Tức Mới Nhất")),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Không có dữ liệu"));
          }

          List<Article> articles = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: articles.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final item = articles[index]; // item là Article

              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    item.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    // Xử lý khi ảnh bị lỗi
                    errorBuilder: (ctx, err, stack) => Container(
                        width: 80, height: 80,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image)
                    ),
                  ),
                ),
                title: Text(
                  item.title, // Giờ nó sẽ không bị đỏ nữa
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(item.publishedAt)),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetailPage(article: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}