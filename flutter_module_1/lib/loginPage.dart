import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/signupPage.dart';
import 'resetPasswordPage.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              const Row(children: <Widget>[
                Text('Email', textAlign: TextAlign.start)
              ]),
              //User input for email
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
              ),
              const Row(children: <Widget>[
                Text('Password', textAlign: TextAlign.start)
              ]),
              //User input for password
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
              ),
              //Text button to send to reset password page
              TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordPage())),
                  child: const Text('Forgot your password?')),
              //Elevated Button to login to send to Home page
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage())), //take off back button later
                  child: const Text('Login')),
              //Text button to send to Sign Up pages
              TextButton(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15)),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage())),
                  child: const Text('Don\'t have an account?')),
            ])));
  }
}
