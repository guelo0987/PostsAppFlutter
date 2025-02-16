import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ApiHandle/handle_posts_api.dart';
import '../components/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<HandlePostsApi>(context, listen: false).fetchPosts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HandlePostsApi>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts Destacados'),
        elevation: 0,
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar posts...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) => provider.searchPosts(value),
              ),
            ),
            Expanded(
              child: provider.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : provider.error != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  size: 60, color: Colors.red),
                              SizedBox(height: 16),
                              Text('Error: ${provider.error}'),
                            ],
                          ),
                        )
                      : provider.posts.isEmpty
                          ? Center(
                              child: Text('No se encontraron resultados'),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              itemCount: provider.posts.length,
                              itemBuilder: (context, index) {
                                final post = provider.posts[index];
                                return PostTile(post: post);
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
