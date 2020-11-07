import 'package:flutter/material.dart';
import 'package:frontend_student/Auxiliar/student.dart';
import 'package:frontend_student/Auxiliar/api_services.dart';
import 'package:frontend_student/Routes/editstudent.dart';

class StudentDetails extends StatefulWidget {
  Student student;
  StudentDetails(this.student);
  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    int id = widget.student.studentID;
    return Scaffold(
      appBar: AppBar(
        title: Text("Student details"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: 440.0,
            child: Column(
              children: [
                // Last Name
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Last name: ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.student.lastName,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),
                ),
                // First Name
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                  child: Column(
                    children: [
                      Text(
                        'First name: ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.student.firstName,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),
                ),
                // Student ID
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Student ID: ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.student.studentID.toString(),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                // Enrollment
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30.0),
                  child: Column(
                    children: [
                      Text(
                        'Enrollment date: ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.student.enrollmentDate.toString(),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                // Buttons
                Container(
                  margin: EdgeInsets.fromLTRB(70, 50, 0, 10.0),
                  child: Row(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditStudent(widget.student),
                            ),
                          );
                        },
                        color: Colors.blue,
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          apiServices.deleteStudent(widget.student.studentID);
                          Navigator.pop(context);
                        },
                        color: Colors.blue,
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Color(0xFFFFFBE6)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
