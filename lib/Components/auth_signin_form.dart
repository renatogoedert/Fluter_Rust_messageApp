//Code Developed By Renato Francisco Goedert

import 'package:flutter/material.dart';

class AuthSignInForm extends StatelessWidget {
  const AuthSignInForm({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailController,
    required this.nameController,
    required this.singInFormKey,
    required this.onSignIn,
    required this.toogleLogin,
    required this.isPasswordVisible,
    required this.tooglePasswordVisibility,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final GlobalKey<FormState> singInFormKey;
  final bool isPasswordVisible;
  final void Function() onSignIn;
  final void Function() toogleLogin;
  final void Function() tooglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: singInFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sign In',
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
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => value != null && value.length >= 6
                ? null
                : 'Enter a valid Full Name',
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
          TextFormField(
            controller: confirmPasswordController,
            decoration: InputDecoration(labelText: 'Confirm Password'),
            obscureText: !isPasswordVisible,
            validator: (value) =>
                confirmPasswordController.text == passwordController.text
                    ? null
                    : 'Passwords must Match',
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onSignIn();
            },
            child: Text('Sign In'),
          ),
          TextButton(
            onPressed: () {
              toogleLogin();
            },
            child: Text('Already have an account? Login'),
          ),
        ],
      ),
    );
  }
}
