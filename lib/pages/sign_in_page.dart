import 'package:flutter/material.dart';
import '../PROFILE/personal_info_screen.dart'; //ทำเชื่อมเพื่อดูไฟล์นี้ชั่วคราว
import '../pages/sign_up_page.dart';  // นำเข้าหน้าสมัครสมาชิก (SignUpPage)

const Color primaryColor = Color(0xFF25AAAC);

class SignInPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            //แถบบน
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(color: Colors.black),
                  TextButton(
                    onPressed: () { //กดละไปหน้าไฟล์ signup
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Text(
                      'ลงชื่อเข้าใช้',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            //ส่วนเนื้อหาล่าง
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'เข้าสู่ระบบ',
                      style:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('กรุณาใส่ชื่อผู้ใช้และรหัสผ่านของคุณเพื่อเข้าสู่ระบบ'),
                    SizedBox(height: 30),
                    // ชื่อผู้ใช้
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'ชื่อผู้ใช้',
                        filled: true,
                        fillColor: Colors.grey[250],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // รหัสผ่าน
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'รหัสผ่าน',
                        filled: true,
                        fillColor: Colors.grey[250],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text('ลืมรหัสผ่าน?'),
                      ),
                    ),
                    //ปุ่มเข้าสู่ระบบ
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        minimumSize: Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () { //โค้ดนี้ใช้ชั่วคราวเพื่อดูหน้าไฟล์แบบสอบถาม
                        // เมื่อกดปุ่มเข้าสู่ระบบจะนำไปที่ PersonalInfoScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PersonalInfoScreen()),
                        );
                      },
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    // ปุ่ม social
                    socialButton('ดำเนินการต่อด้วย Google',
                        icon: Icons.g_mobiledata, color: Colors.black),
                    SizedBox(height: 10),
                    socialButton('ดำเนินการต่อด้วย Facebook',
                        icon: Icons.facebook, color: Color(0xFF1877F2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialButton(String text, {required IconData icon, Color? color}) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(color: Colors.black)),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
