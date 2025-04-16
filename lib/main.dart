import 'package:flutter/material.dart';
import 'PROFILE/exercise_question.dart';      // แบบสอบถาม
import 'HOME/progress_page.dart';            // หน้า ProgressPage
import 'MODELS/health_data.dart';            // โมเดลข้อมูลสุขภาพ
import 'HOME/home_page.dart';
import 'pages/welcome_page.dart'; // เพิ่มการนำเข้า WelcomePage



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primaryColor: const Color(0xFF25AAAC),
        fontFamily: 'Prompt',
      ),
      home: const WelcomePage(), // ตั้งค่า home เป็น WelcomePage
    );
  }
}
