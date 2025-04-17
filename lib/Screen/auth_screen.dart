//Code Developed By Renato Francisco Goedert

import 'package:fluter_rust_message_app/Components/auth_login_form.dart';
import 'package:fluter_rust_message_app/Components/auth_signin_form.dart';
import 'package:fluter_rust_message_app/Provider/auth_provider.dart'
    show AuthProvider;
import 'package:fluter_rust_message_app/Screen/dashboard_screen.dart'
    show DashboardScreen;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:provider/provider.dart';

import '../src/rust/lib.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //Controller for email text
  final TextEditingController _emailController = TextEditingController();

  //Controller for name text
  final TextEditingController _nameController = TextEditingController();

  //Controller for password text
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //Keys for the Froms
  final _loginFormKey = GlobalKey<FormState>();
  final _singInFormKey = GlobalKey<FormState>();

  //Variables for manage State
  bool isLogin = true;
  bool isPasswordVisible = false;
  String errorText = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<String> getMessagesFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/users.txt';
  }

  void _toogleLogin() {
    setState(() {
      isPasswordVisible = false;
      errorText = "";
      isLogin = !isLogin;
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  void _tooglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void _tryLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        errorText = '';
      });
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await validateUser(
        filePath: await getMessagesFilePath(),
        email: email,
        password: password);

    if (user != null) {
      setState(() {
        isPasswordVisible = false;
        errorText = '';
      });

      if (!mounted) return;
      context.read<AuthProvider>().login(user);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => const DashboardScreen(
                  title: "",
                )),
      );
    } else {
      setState(() {
        errorText = 'Unbable to login';
      });
      print('unable to login');
    }
  }

  void _trySignIn() async {
    final isValid = _singInFormKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        errorText = '';
      });
      return;
    }
    await addUser(
        filePath: await getMessagesFilePath(),
        email: _emailController.text,
        name: _nameController.text,
        password: _passwordController.text,
        avatarUrl: "");

    _toogleLogin();
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
            padding: const EdgeInsets.all(18.0),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: isLogin
                  ? AuthLoginForm(
                      passwordController: _passwordController,
                      emailController: _emailController,
                      onLogin: _tryLogin,
                      loginFormKey: _loginFormKey,
                      errorText: errorText,
                      isPasswordVisible: isPasswordVisible,
                      toogleLogin: _toogleLogin,
                      tooglePasswordVisibility: _tooglePasswordVisibility,
                    )
                  : AuthSignInForm(
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      emailController: _emailController,
                      nameController: _nameController,
                      singInFormKey: _singInFormKey,
                      isPasswordVisible: isPasswordVisible,
                      onSignIn: _trySignIn,
                      toogleLogin: _toogleLogin,
                      tooglePasswordVisibility: _tooglePasswordVisibility,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
