import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'student.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String url = "https://backenddapi.azurewebsites.net/api/students";
  // Get
  Future<List<Student>> getStudents() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Student.fromJson(job)).toList();
    } else
      throw Exception('Failed to load students from API');
  }

  // Post
  Future<Student> postStudent(Student student) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    Map data = {
      'StudentID': student.studentID,
      'LastName': student.lastName,
      'FirstName': student.firstName,
      'EnrollmentDate': DateTime.now().toIso8601String() + '+00:00'
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        //'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201)
      return Student.fromJson(json.decode(response.body));
    else
      throw Exception('Failed to post student');
  }

  //Put
  // ignore: missing_return
  Future<Student> putStudent(int id, Student student) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');
    Map data = {
      'StudentID': id,
      'LastName': student.lastName,
      'FirstName': student.firstName,
      'EnrollmentDate': DateTime.now().toIso8601String() + '+00:00'
    };

    final response = await http.put(
      '$url/$id',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 204)
      throw Exception("Failed to update a student");
  }

  //Delete
  Future<void> deleteStudent(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    final response = await http.delete(
      '$url/$id',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200)
      return Student.fromJson(json.decode(response.body));
    else
      throw Exception("Failed to delete the student");
  }
}
