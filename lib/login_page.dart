import 'package:flutter/material.dart';
import 'package:flutter_simple_login_ui/services/api_service.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Create controllers to manage the text input for username and password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService _apiService = ApiService();  // Create an instance of ApiService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextField for username input
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16), // Add some space between the fields
                // TextField for password input
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  obscureText: true, // Hide the password text
                ),
                const SizedBox(height: 24), // Add some space before the button
                // Login button
                ElevatedButton(
                  onPressed: () async {
                    String email = _usernameController.text;
                    String password = _passwordController.text;

                    if (email.isEmpty || password.isEmpty) {
                      // Show an alert dialog if the fields are empty
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please enter email and password'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    try {
                      // Call the login API
                      final response = await _apiService.login(email, password);

                      // Check if login was successful
                      if (response['success']) {
                        // Store the token, if necessary, and navigate
                        Navigator.pushNamed(context, '/dashboard');
                      } else {
                        // Show an error dialog if login failed
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text(response['message']),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } catch (e) {
                      // Handle API error
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text('Failed to login. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Change the button color here
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Login',style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
