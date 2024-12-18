import 'package:flutter/material.dart';
import 'package:hoki_lo_kocak/Constants/colors.dart';
import 'package:hoki_lo_kocak/LoginFeature/RegisterPage.dart';
import 'package:hoki_lo_kocak/MainPage.dart';
import 'package:hoki_lo_kocak/Services/AuthService.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _signIn() async {
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        _showMessage("Please enter email and password.");
        return;
      }

      final user = await _authService.signInWithEmailAndPassword(email, password);
      if (user != null) {
        _showMessage("Login successful!");
        _directNavigationToMainPage();
      }
    } catch (e) {
      _showMessage(e.toString());
    }
  }

  void _directNavigationToMainPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: darkRedColor.withOpacity(0.1),
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome To Hoki Lo Kocak",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: darkRedColor
                    ),
                  ),
                  SizedBox(height: 20,),

                  Image.asset(
                    'assets/images/loginPageImage.webp',
                    height: 300,
                  ),
                  SizedBox(height: 40,),

                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      prefixIcon: Icon(Icons.email)
                    ),
                  ),
                  SizedBox(height: 20,),

                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        prefixIcon: Icon(Icons.lock)
                    ),
                  ),
                  SizedBox(height: 30,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: _signIn,
                        icon: Icon(Icons.login, color: Colors.white,),
                        label: Text(
                          'Sign In With Email',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Warna background tombol
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 20,),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => RegisterPage())
                          );
                        },
                        icon: Icon(Icons.login, color: Colors.white,),
                        label: Text(
                          'Sign Up With Email',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // Warna background tombol
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 20,),
                  
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          _directNavigationToMainPage();
                        },
                        child: Text(
                          "Continue as Guest",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]
                          ),
                        ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}