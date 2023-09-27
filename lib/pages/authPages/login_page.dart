// ignore_for_file: avoid_print, unused_import, use_build_context_synchronously

import 'package:baby/models/parent.dart';
import 'package:baby/pages/authPages/forgot_pw_page.dart';
import 'package:baby/pages/home_page.dart';
import 'package:baby/pages/authPages/register_page.dart';
import 'package:baby/provider/parent_provider.dart';
import 'package:baby/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controller
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPassword = false;
  bool? loginSuccessful;

  //thông báo lỗi
  String? emailError;
  String? passwordError;

  //kiểm tra định dạng email
  bool isEmailValid(String email) {
    final RegExp regex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return regex.hasMatch(email);
  }

  //hàm kiểm tra đăng nhập
  Future<void> signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Đặt lại thông báo lỗi
    setState(() {
      emailError = null;
      passwordError = null;
    });

    // Logic kiểm tra
    // Logic kiểm tra định dạng email
    if (!isEmailValid(email)) {
      setState(() {
        emailError = "Vui lòng nhập một email hợp lệ.";
      });
    } else {
      setState(() {
        emailError = null;
      });
    }

    if (password.isEmpty || password.length < 6) {
      setState(() {
        passwordError = "Vui lòng nhập mật khẩu có ít nhất 6 ký tự.";
      });
    } else {
      setState(() {
        passwordError = null;
      });
    }

    // Kiểm tra xem có lỗi nào không trước khi tiến hành đăng ký
    if (emailError != null || passwordError != null) {
      return; // Không tiếp tục đăng ký nếu có lỗi
    }

    try {
      final auth = FirebaseAuth.instance;
      // Thử đăng nhập bằng email và mật khẩu đã cung cấp
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        await user.reload();
        if (!user.emailVerified) {
          setState(() {
            emailError = "Email chưa được xác thực";
          });
          return; // Dừng hàm nếu email chưa được xác thực
        }

        // Lấy thông tin người dùng từ Firestore dựa trên email
        final userData = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (userData.docs.isNotEmpty) {
          final userDataMap = userData.docs[0].data();
          final parent = Parent(
            email: userDataMap['email'],
            phone: userDataMap['phone'],
            name: userDataMap['name'],
            dob: userDataMap['dob'],
            gender: userDataMap['gender'],
            address: userDataMap['address'],
            avatar: userDataMap['avatar'],
            // Các trường thông tin khác
          );

          // Cập nhật thông tin người dùng vào Provider
          final parentProvider =
              Provider.of<ParentProvider>(context, listen: false);
          parentProvider.setParent(parent);

          //test thông tin lấy về
          print("thông tinparentProvider: ${parentProvider.parent?.name}");
          // Đăng nhập thành công, điều hướng đến màn hình chính.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }

        print('Đăng nhập thành công');
        // Đăng nhập thành công, điều hướng đến màn hình chính
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Lỗi đăng nhập: ${e.code}"); // In ra mã lỗi để xác định lỗi cụ thể
      if (e.code == 'too-many-requests') {
        // Xử lý lỗi quá nhiều yêu cầu đăng nhập
        setState(() {
          emailError =
              "Nhiều yêu cầu đăng nhập không hợp lệ. Vui lòng thử lại sau";
          passwordError =
              null; // Đặt null cho mật khẩu để không hiển thị thông báo lỗi mật khẩu
        });
      }
      if (e.code == 'INVALID_LOGIN_CREDENTIALS' || e.code == 'wrong-password') {
        // Email hoặc mật khẩu không chính xác
        setState(() {
          emailError = "Địa chỉ email hoặc mật khẩu không chính xác.";
          passwordError = "Địa chỉ email hoặc mật khẩu không chính xác.";
        });
      } else {
        // Xử lý các lỗi FirebaseAuthException khác nếu cần
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 244, 244),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenSize.height / 10),
              Image.asset(
                "assets/images/logo copy.png",
                width: screenSize.height / 4,
                height: screenSize.height / 4,
              ),
              SizedBox(height: screenSize.height / 20),
              const SizedBox(
                height: 8,
              ),
              TextFieldCustomize(
                controller: _emailController,
                borderColor: const Color.fromRGBO(251, 219, 219, 0.612),
                boxColor: Colors.white,
                textInputType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.mail),
                width: screenSize.width - 16,
                height: screenSize.height / 16,
                hintText: "Email",
                errorText: emailError,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldCustomize(
                obscureText: !isPassword,
                controller: _passwordController,
                boxColor: Colors.white,
                borderColor: const Color.fromRGBO(251, 219, 219, 0.612),
                suffixicon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: isPassword ? Colors.blue : Colors.black,
                    )),
                prefixIcon: const Icon(Icons.lock),
                width: screenSize.width - 16,
                height: screenSize.height / 16,
                hintText: "Mật khẩu",
                errorText: passwordError,
              ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()));
                      },
                      child: Text(
                        "Quên mật khẩu",
                        style: GoogleFonts.getFont(
                          'Inter',
                          //fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: signIn,
                child: Container(
                  height: screenSize.height / 16,
                  width: screenSize.width - 144,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 123, 19),
                    borderRadius: BorderRadius.circular(screenSize.height / 16),
                  ),
                  child: Center(
                      child: Text(
                    "Đăng nhập",
                    style: GoogleFonts.getFont('Inter',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              RichText(
                text: TextSpan(
                  text: 'Bạn chưa có tài khoản? ',
                  style: GoogleFonts.getFont(
                    'Inter',
                    //fontWeight: FontWeight.bold,
                    fontSize: 14,
                    //fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Đăng ký ngay',
                      style: GoogleFonts.getFont('Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
