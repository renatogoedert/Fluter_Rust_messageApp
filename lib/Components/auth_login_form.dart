//Code Developed By Renato Francisco Goedert

import 'package:flutter/material.dart';

class AuthLoginForm extends StatelessWidget {
  const AuthLoginForm({
    super.key,
    required this.passwordController,
    required this.emailController,
    required this.loginFormKey,
    required this.onLogin,
    required this.errorText,
    required this.toogleLogin,
    required this.isPasswordVisible,
    required this.tooglePasswordVisibility,
  });

  final TextEditingController passwordController;
  final TextEditingController emailController;
  final GlobalKey<FormState> loginFormKey;
  final String errorText;
  final bool isPasswordVisible;
  final void Function() onLogin;
  final void Function() toogleLogin;
  final void Function() tooglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value != null && value.contains('@')
                ? null
                : 'Enter a valid email',
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                    onPressed: tooglePasswordVisibility,
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility))),
            obscureText: !isPasswordVisible,
            validator: (value) => value != null && value.length >= 6
                ? null
                : 'Password must be at least 6 characters',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onLogin();
            },
            child: Text('Login'),
          ),
          if (errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorText,
                style: TextStyle(color: Colors.red),
              ),
            ),
          TextButton(
            onPressed: () {
              toogleLogin();
            },
            child: Text('Create Your account!'),
          ),
        ],
      ),
    );
  }
}
