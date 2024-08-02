import 'package:finance_expenses/Authentication/RegistrainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Lateuse/Colors.dart';
import 'HomePage.dart';
import 'ResetPasswordPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(user: userCredential.user!)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                  border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      width: 2), // Added border
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(CupertinoIcons.profile_circled,
                                color: primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primary)),
                          labelText: 'Email'),
                    ),
                    SizedBox(height: height * 0.03),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                          prefix: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(CupertinoIcons.lock, color: primary),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primary),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primary)),
                          labelText: 'Password'),
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary.shade100,
                          minimumSize: Size(double.infinity, 56),
                          textStyle: TextStyle(),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            side:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 0),
                          Text('Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 0, 0, 0))),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegistrationPage()));
                      },
                      child: const Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()));
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
