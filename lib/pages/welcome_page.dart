import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';


const Color primaryColor = Color(0xFF25AAAC);

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double _opacity = 0.0;
  double _paddingTop = 80;
  double _bottomHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenHeight = MediaQuery.of(context).size.height;
      setState(() {
        _opacity = 1.0;
        _paddingTop = 40;
        _bottomHeight = screenHeight / 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //โลโก้ด้านบน
            Expanded(
              child: AnimatedPadding(
                duration: Duration(milliseconds: 600),
                padding: EdgeInsets.only(top: _paddingTop),
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 800),
                  opacity: _opacity,
                  curve: Curves.easeIn,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    height: _bottomHeight > 0 ? _bottomHeight : 180,
                    color: Colors.white,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'EASCHECK',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'NUTRISCAN',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 2,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // กล่องข้อความด้านล่าง
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ยินดีต้อนรับ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),//ระยะห่างระหว่างยินดีต้อนรับกับข้อความด้านล่าง
                  Text(
                    'ยินดีต้อนรับสู่แอปพลิเคชันของเรา\nโปรดเข้าสู่ระบบหรือลงชื่อเข้าใช้เพื่อเริ่มต้น',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),//ระยะห่างระหว่างข้อความด้านบนกับปุ่มข้างล่าง
                  Row(
                    children: [
                      // ปุ่มเข้าสู่ระบบ
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom( //สร้างปุ่ม
                            backgroundColor: Colors.white, //สีพื้นหลัง
                            side: BorderSide(color: Colors.black54), //สีกรอบ
                            padding: EdgeInsets.symmetric(vertical: 18),//ระยะห่างในปุ่มเข้าสู่ระบบ
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),//ปรับมุมโค้งปุ่มเข้าสู่ระบบ
                            ),
                          ),
                          // จะให้ปุ่มนี้พาไปหน้าไหน
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignInPage(), //เชื่อมหน้าไฟล์ sign_in_page.dart
                              ),
                            );
                          },
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(width: 12), //ตัวกรอบ
                      // ปุ่มลงชื่อเข้าใช้
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: Colors.white), //สีกรอบ
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SignUpPage(), // ต้อง import SignUpPage ด้านบน
                              ),
                            );
                          },

                          child: Text('ลงชื่อเข้าใช้'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
