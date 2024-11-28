import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
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
                      color: Colors.deepOrange
                    ),
                  ),
                  SizedBox(height: 20,),

                  Image.asset(
                    'assets/images/loginPageImage.webp',
                    height: 400,
                  ),
                  SizedBox(height: 40,),

                  TextField(
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
                        onPressed: () {
                          print("Lakukan Login");
                        },
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
                          print("Lakukan Register");
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
                          print("Masuk sebagai guest");
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