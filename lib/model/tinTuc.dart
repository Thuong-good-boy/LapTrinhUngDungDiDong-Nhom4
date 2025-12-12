class tinTuc {
  Information information;
  int totalArticles;
  List<Article> articles;

  tinTuc({
    required this.information,
    required this.totalArticles,
    required this.articles,
  });
  factory tinTuc.fromJson(Map<String, dynamic> json) {
    return tinTuc(
      information: Information.fromJson(json['information'] ?? {}),
      totalArticles: json['totalArticles'] ?? 0,
      articles: List<Article>.from(
          (json['articles'] ?? []).map((x) => Article.fromJson(x))),
    );
  }

}

class Article {
  String id;
  String title;
  String description;
  String content;
  String url;
  String image;
  DateTime publishedAt;
  String lang;
  Source source;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.lang,
    required this.source,
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: json['title'] ?? 'Không có tiêu đề',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/400x200',
      publishedAt: DateTime.tryParse(json['publishedAt'] ?? '') ?? DateTime.now(),
      lang:json['lang']??"",
      source: Source.fromJson(json['source'] ?? {}),
    );
  }

}


class Source {
  String id;
  String name;
  String url;

  Source({
    required this.id,
    required this.name,
    required this.url,
  });
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Source',
      url: json['url'] ?? '',
    );
  }

}

class Information {
  RealTimeArticles realTimeArticles;

  Information({
    required this.realTimeArticles,
  });
  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      realTimeArticles:
      RealTimeArticles.fromJson(json['realTimeArticles'] ?? {}),
    );
  }
}

class RealTimeArticles {
  String message;

  RealTimeArticles({
    required this.message,
  });
  factory RealTimeArticles.fromJson(Map<String, dynamic> json) {
    return RealTimeArticles(
      message: json['message'] ?? '',
    );
  }

}
