import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend_student/main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.black38),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                titleSection(),
                textSection(),
                buttonSection(),
              ],
            ),
    ));
  }

  Container titleSection() {
    return Container(
      margin: EdgeInsets.only(
        top: 50.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        "Student",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Colors.white70,
              ),
              hintText: "Email",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.white70,
              ),
              hintText: "Password",
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'grant_type': 'password', 'username': email, 'password': pass};
    var jsonResponse;
    var response = await http.post(
      "https://backenddapi.azurewebsites.net/token",
      body: data,
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['access_token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => StudentHome()),
            (Route<dynamic> route) => false);
      }
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.yellow,
        child: Text("Sign in", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
