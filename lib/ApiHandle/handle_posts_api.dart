import 'package:flutter/material.dart';
import '../models/post.dart';
import '../Api/service.dart';

//Change Notifier lo que me permite notificar
// a los widgets cuando hay cambios
class HandlePostsApi with ChangeNotifier {
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = true;
  String? _error;
  String _searchQuery = '';

  List<Post> get posts => _searchQuery.isEmpty ? _posts : _filteredPosts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final ApiService _apiService = ApiService();

  Future<void> fetchPosts() async {
    try {
      _isLoading = true;
      notifyListeners();

      _posts = await _apiService.fetchPosts();
      _filteredPosts = _posts;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchPosts(String query) {
    _searchQuery = query.toLowerCase();
    if (_searchQuery.isEmpty) {
      _filteredPosts = _posts;
    } else {
      _filteredPosts = _posts.where((post) {
        return post.title.toLowerCase().contains(_searchQuery) ||
            post.body.toLowerCase().contains(_searchQuery);
      }).toList();
    }
    notifyListeners();
  }
}
