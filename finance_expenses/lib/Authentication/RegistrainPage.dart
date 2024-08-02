import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../Lateuse/Colors.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to register: $e')),
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
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Register',
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
                            child: Icon(CupertinoIcons.mail, color: primary),
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
                      onPressed: _register,
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
                          Text('Register',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 0, 0, 0))),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                      child: const Text('Already have an account? Login'),
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
