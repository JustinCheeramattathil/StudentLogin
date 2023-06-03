import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/data_model.dart';
import 'screens/adsreensection/add_std.dart';
import 'screens/home.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/add': (context) => Add(),
      },
      initialRoute: '/',
    );
  }
}
