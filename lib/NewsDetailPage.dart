import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn2110/model/tinTuc.dart';
class NewsDetailPage extends StatelessWidget {
  final Article article;

  const NewsDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chi Tiết")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.image,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const SizedBox(height: 200, child: Icon(Icons.error)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Chip(label: Text(article.source.name)),
                      const Spacer(),
                      Text(DateFormat('HH:mm dd/MM/yyyy').format(article.publishedAt)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.description,
                    style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16, color: Colors.black87),
                  ),
                  const Divider(height: 30),
                  Text(
                    article.content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}