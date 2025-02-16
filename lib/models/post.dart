class Post {
  final int id;
  final String title;
  final String body;
  final String imageUrl;

  Post({required this.id, required this.title, required this.body, required this.imageUrl});

  //Me convierte los datos json en un objeto tipo Post
  factory Post.fromJson(Map<String, dynamic> json, String imageUrl) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      imageUrl: imageUrl,
    );
  }
}
