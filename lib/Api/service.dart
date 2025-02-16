import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String postsUrl = "https://jsonplaceholder.typicode.com/posts";
  static const String baseImageUrl = "https://picsum.photos/seed";

  String getImageUrl(int postId) {
    return '$baseImageUrl/$postId/800/400';
  }

  Future<List<Post>> fetchPosts() async {
    try {
      final postsResponse = await http.get(Uri.parse(postsUrl));

      if (postsResponse.statusCode == 200) {
        List<dynamic> postsData = jsonDecode(postsResponse.body);
        postsData = postsData.take(10).toList();

        return postsData.map((postJson) {
          final int postId = postJson['id'];
          final String imageUrl = getImageUrl(postId);
          return Post.fromJson(postJson, imageUrl);
        }).toList();
      } else {
        throw Exception("Error al obtener los datos de la API");
      }
    } catch (e) {
      throw Exception("Error de conexión: $e");
    }
  }
}
