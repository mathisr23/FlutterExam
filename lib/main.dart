import 'package:eval_flutter/views/login_page.dart';
import 'package:eval_flutter/views/user_information.dart';
import 'package:flutter/material.dart';
import 'package:eval_flutter/model/user_id_generator.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  final userIDGenerator = UserIDGenerator();

  runApp(MyApp(userIDGenerator: userIDGenerator));
}


class MyApp extends StatelessWidget {
  final UserIDGenerator userIDGenerator;

  MyApp({required this.userIDGenerator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginPage(),
        '/user_information': (context) => UserInformation(),
      },
      initialRoute: '/',
    );
  }
}





