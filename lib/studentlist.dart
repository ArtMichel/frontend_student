import 'package:flutter/material.dart';
import 'Auxiliar/api_services.dart';
import 'Auxiliar/student.dart';
import 'Routes/studentdetails.dart';

class StudentsListView extends StatelessWidget {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    ListTile _tile(
        int id, String lastName, String firstName, DateTime enrollmentDate) {
      Student student =
          Student.newStudent(id, lastName, firstName, enrollmentDate);
      return ListTile(
        title: Text(
          firstName + ' ' + lastName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          'ID: ' + id.toString(),
          style: TextStyle(fontSize: 15.0),
        ),
        leading: Icon(
          Icons.person,
          color: Colors.grey,
          size: 45.0,
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white60,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentDetails(student)),
          );
        },
      );
    }

    // receive data from the next
    ListView _studentsListView(data) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
            data[index].studentID,
            data[index].lastName,
            data[index].firstName,
            data[index].enrollmentDate,
          );
        },
      );
    }

    return FutureBuilder<List<Student>>(
      future: apiServices.getStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Student> data = snapshot.data;
          return _studentsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
