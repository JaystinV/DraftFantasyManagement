import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_module_1/dbConnect.dart";
import "package:flutter_module_1/signupPage.dart";
import "package:postgres/postgres.dart";
import "resetPasswordPage.dart";
import "homePage.dart";
import 'dart:async';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  PostgresConnection connectionTeamManagers = PostgresConnection();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> getCurrentUsername() async {
    bool checkLogin = await connectionTeamManagers.checkAccount(
        usernameController.text, passwordController.text);
    return checkLogin;
  }

  @override
  initState() {
    super.initState();
    usernameController.text = 'theFirstUser';
    passwordController.text = 'password123';
  }

  void userSignIn() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Row(children: <Widget>[
                    Text("Username", textAlign: TextAlign.start)
                  ]),
                  //User input for username
                  TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                        hintText: "JohnSmith12",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Username.";
                        }
                        return null;
                      }),
                  const Row(children: <Widget>[
                    Text("Password", textAlign: TextAlign.start)
                  ]),
                  //User input for password
                  TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        hintText: "password1234",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Password.";
                        }
                        return null;
                      }),
                  //Text button to send to reset password page
                  TextButton(
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordPage())),
                      child: const Text("Forgot your password?")),
                  //Elevated Button to login to send to Home page
                  ElevatedButton(
                      onPressed: () async {
                        bool checkCredentials = await getCurrentUsername();
                        if (checkCredentials == true) {
                          Navigator.push(
                              //using build context across async gaps
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(
                                      userLoggedIn: usernameController.text,
                                      newLeagueName: "",
                                      newRounds:
                                          0))); //take off back button later
                        } else {
                          const failSnackBar =
                              SnackBar(content: Text("Incorrect credentials"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(failSnackBar);
                        }
                      },
                      child: const Text("Login")),
                  //Text button to send to Sign Up pages
                  TextButton(
                      style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage())),
                      child: const Text("Don\"t have an account?")),
                ])));
  }
}
