// ignore_for_file: use_build_context_synchronously

import 'package:baby/pages/authPages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xác minh Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Vui lòng kiểm tra email của bạn và bấm vào liên kết xác minh để hoàn tất đăng ký.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Kiểm tra lại xem email đã được xác minh chưa
                final user = FirebaseAuth.instance.currentUser;
                await user?.reload();
                if (user != null && user.emailVerified) {
                  // Email đã được xác minh, điều hướng đến màn hình chính
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  // Hiển thị thông báo nếu email chưa được xác minh
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Email chưa được xác minh.'),
                    ),
                  );
                }
              },
              child: const Text('Kiểm tra xác minh Email'),
            ),
          ],
        ),
      ),
    );
  }
}
