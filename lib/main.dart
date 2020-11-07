import 'package:flutter/material.dart';
import 'Routes/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'studentlist.dart';
import 'Routes/addstudent.dart';

// Main App
void main() => runApp(StudentApp());

class StudentApp extends StatelessWidget {
  const StudentApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FrontEnd StudentApp",
      home: StudentHome(),
    );
  }
}

// Home Screen
class StudentHome extends StatefulWidget {
  StudentHome({Key key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students App", style: TextStyle(color: Colors.white70)),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Log Out", style: TextStyle(color: Colors.white))),
        ],
      ),
      body: Center(
        child: StudentsListView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "Add Student",
        ),
        icon: Icon(
          Icons.add,
          color: Color(0xFFFFFBE6),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
