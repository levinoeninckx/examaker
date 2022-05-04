import 'package:examaker/adminHome.dart';
import 'package:examaker/main.dart';
import 'package:examaker/studentHome.dart';
import 'package:examaker/validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({Key? key}) : super(key: key);
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //Dispose of controller when widget dissapears
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Examator - AP Hogeschool"),
          centerTitle: true,
        ),
        //LoginForm
        body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text("Username"),
            TextFormField(
              controller: usernameController,
              validator: (value) => Validator.validateEmail(email: value),
            ),
            const SizedBox(height: 8.0),
            Text("Password"),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              validator: (value) => Validator.validatePassword(password: value),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    User? user = await FireAuth.signInUsingEmailPassword(
                        email: usernameController.text,
                        password: passwordController.text);
                    if (user != null) {
                      if(user.email == "testadmin@ap.be"){
                          Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => AdminHome()));
                      }
                      else if(user.email == "test@ap.be"){
                          Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => StudentHome()));
                      }
                      
                    }
                  }
                },
                child: const Text('Log in'))
          ]),
        ));
  }
}