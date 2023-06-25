import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pr_2/model/data_model.dart';

class providerclass with ChangeNotifier {
  List<StudentModel> StudentList = [];
  List<StudentModel> studentSearchResult = [];
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text(
    "Student records",
  );

  set setStudentSearchResult(List<StudentModel> list) {
    studentSearchResult = list;
    notifyListeners();
  }

  Future<int> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.put(value.id, value);

    getAllStudent();

    return 0;
  }

  Future<void> deleteStudent(context, String id) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.delete(id);
    getAllStudent();
  }

  Future<void> updateStudent(StudentModel model) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.put(model.id, model);
  }

  Future<void> getAllStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');

    StudentList.clear();
    StudentList.addAll(studentDB.values);
    notifyListeners();
  }

  Future<void> search(String text) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');

    StudentList.clear();
    StudentList.addAll(
        studentDB.values.where((element) => element.name.contains(text)));
    notifyListeners();
  }

  static of(BuildContext ctx, {required bool listen}) {}

  void transform() {
    if (cusIcon.icon == Icons.search) {
      cusIcon = Icon(
        Icons.cancel,
        color: Colors.black,
      );
      cusSearchBar = TextField(
        onChanged: (value) {
          search(value);
        },
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: 'Search',
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      );
    } else {
      cusIcon = Icon(
        Icons.search,
        color: Colors.black,
      );
      cusSearchBar = Text("Student records");
    }
    notifyListeners();
  }
}
