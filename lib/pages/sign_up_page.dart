import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // TODO: เชื่อมต่อระบบ backend สำหรับสมัครสมาชิก
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('สมัครสมาชิกสำเร็จ')),
      );
      Navigator.pop(context); // กลับไปยังหน้า Welcome หรือ Sign in
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียน'),
        backgroundColor: Color(0xFF25AAAC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField( // ช่องใส่ชื่อผู้ใช้
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'ชื่อผู้ใช้',
                  filled: true,
                  fillColor: Colors.grey[250],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? 'กรุณากรอกชื่อผู้ใช้' : null,
              ),
              SizedBox(height: 24),

              TextFormField( // ช่องใส่อีเมล
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'อีเมล',
                  filled: true,
                  fillColor: Colors.grey[250],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value!.isEmpty ? 'กรุณากรอกอีเมล' : null,
              ),
              SizedBox(height: 24),

              TextFormField( // ช่องใส่รหัสผ่าน
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'รหัสผ่าน',
                  filled: true,
                  fillColor: Colors.grey[250],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                validator: (value) =>
                value!.length < 6 ? 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร' : null,
              ),
              SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF25AAAC),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                onPressed: _register,
                child: Text('ลงทะเบียน'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

