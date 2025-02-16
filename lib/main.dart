import 'package:flutter/material.dart';
import 'package:juniorflutter/ApiHandle/handle_posts_api.dart';
import 'package:provider/provider.dart';
import 'ApiHandle/handle_posts_api.dart';
import 'pages/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => HandlePostsApi()), // Asegúrate de que está aquí
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
