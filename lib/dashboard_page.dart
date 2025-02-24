import 'package:flutter/material.dart';
import 'package:flutter_simple_login_ui/services/api_service.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ApiService _apiService = ApiService();
  List<dynamic> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              posts = await _apiService.getAllPosts();
              setState(() {});
            },
            child: const Text('Get Posts'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['title']),
                  subtitle: Text(posts[index]['body']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}