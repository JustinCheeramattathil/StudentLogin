import 'package:hive_flutter/hive_flutter.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String age;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String domain;
  @HiveField(5)
  final String img;

  StudentModel(
      {required this.name,
      required this.age,
      required this.phone,
      required this.domain,
      required this.id,
      required this.img});
}
