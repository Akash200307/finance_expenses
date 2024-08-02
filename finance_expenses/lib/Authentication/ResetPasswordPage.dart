import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Lateuse/Colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();

  void _resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send password reset email: $e')),
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
                      color: const Color.fromRGBO(0, 0, 0, 1), width: 2),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'Reset Password',
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
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: _resetPassword,
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
                          Text('Reset Password',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 0, 0, 0))),
                        ],
                      ),
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
