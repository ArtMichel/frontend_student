import 'package:flutter/material.dart';
import 'package:frontend_student/Auxiliar/student.dart';
import 'package:frontend_student/Auxiliar/api_services.dart';

class AddStudent extends StatelessWidget {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Student",
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30.0, 0, 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 13.5, vertical: 5),
                    width: 200,
                    height: 30,
                    child: Text(
                      "Student Information",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next_rounded,
                              size: 50.0,
                            ),
                            Text(
                              "First Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                              labelText: "Introduce el nombre",
                              labelStyle: TextStyle(),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next_rounded,
                              size: 50.0,
                            ),
                            Text(
                              "Last Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: lastName,
                            decoration: InputDecoration(
                              labelText: "Introduce el apellido",
                              labelStyle: TextStyle(),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFFFFBE6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  Student newStudent = Student.newStudent(
                    50,
                    lastName.text,
                    firstName.text,
                    DateTime.now(),
                  );
                  apiServices.postStudent(newStudent);
                  Navigator.pop(context);
                },
                color: Colors.blue,
                splashColor: Color(0xFF356859),
                child: Text(
                  "Add Student",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
