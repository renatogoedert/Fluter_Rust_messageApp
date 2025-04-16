//Code Developed By Renato Francisco Goedert

import 'package:fluter_rust_message_app/Components/auth_login_form.dart';
import 'package:fluter_rust_message_app/Screen/dashboard_screen.dart'
    show DashboardScreen;
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //Controller for email text
  final TextEditingController _emailController = TextEditingController();

  //Controller for password text
  final TextEditingController _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  String errorText = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _tryLogin() {
    final isValid = _loginFormKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        errorText = '';
      });
      return;
    }

    // Add authentication logic here
    if (_emailController.text == 'bart@simpson.ie' &&
        _passwordController.text == "123456") {
      setState(() {
        errorText = '';
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardScreen(title: "title")));
    } else {
      setState(() {
        errorText = 'Unbable to login';
      });
      print('unable to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: AuthLoginForm(
                passwordController: _passwordController,
                emailController: _emailController,
                onLogin: _tryLogin,
                loginFormKey: _loginFormKey,
                errorText: errorText,
              )),
        ),
      ),
    );
  }
}
