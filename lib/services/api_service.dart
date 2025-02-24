import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  final String baseUrl = 'https://localhost:7003/api/auth/Login';

  // Function to login the user
  Future<Map<String, dynamic>> login(String email, String password) async {

    try {
      // Prepare the payload (request body)
      Map<String, String> body = {
        "email": email,
        "password": password,
      };

      // Send POST request
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Handle the response
      if (response.statusCode == 200) {
        // If server returns 200 OK, return the JSON response
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Error: $e');
    }
  }

Future getAllPosts() async{
  try {
    
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  } catch (e) {
     throw Exception('Error: $e');
  }
}



}
