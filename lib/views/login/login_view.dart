import 'package:flutter/material.dart';
import '../../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = LoginController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  void _handleLogin() {
    _loginController.login(
      _emailController.text,
      _passwordController.text,
    );
    Navigator.pushReplacementNamed(
        context, '/todo'); // Ensure '/todo' route is defined
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4e54c8),
                  Color(0xFF8f94fb)
                ], // Adjust the colors for your design
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isLargeScreen = constraints.maxWidth > 600;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Login form
                        Container(
                          width: isLargeScreen ? 400 : double.infinity,
                          padding: EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.0),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                  ),
                                  Text('Remember me'),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: _handleLogin,
                                child: Text('LOGIN'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  backgroundColor: Color(0xFFf06292),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'Or login with',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.facebook),
                                    color: Colors.blue,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.g_translate),
                                    color: Colors.red,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.apple),
                                    color: Colors.black,
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  // Forgot Password action
                                },
                                child: Text('Forgot Password?'),
                              ),
                              SizedBox(height: 16.0),
                              TextButton(
                                onPressed: () {
                                  // Navigate to Sign up screen
                                },
                                child: Text('Don\'t have an account? Sign up'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
