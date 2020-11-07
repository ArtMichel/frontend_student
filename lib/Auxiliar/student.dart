class Student {
  int studentID;
  String lastName;
  String firstName;
  DateTime enrollmentDate;

  Student({this.studentID, this.lastName, this.firstName, this.enrollmentDate});

  Student.newStudent(int id, String last, String first, DateTime enrollment) {
    this.studentID = id;
    this.lastName = last;
    this.firstName = first;
    this.enrollmentDate = enrollment;
  }

  factory Student.fromJson(Map<dynamic, dynamic> json) {
    return Student(
      studentID: json['StudentID'] as int,
      lastName: json['LastName'] as String,
      firstName: json['FirstName'] as String,
      enrollmentDate: DateTime.parse(json['EnrollmentDate']),
    );
  }
}
