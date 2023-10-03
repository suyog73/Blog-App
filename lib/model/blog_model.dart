class BlogModel {
  final String id;
  final String imageUrl;
  final String title;

  BlogModel({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'title': title,
    };
  }
}
