// ignore_for_file: avoid_print, unused_import
import 'package:baby/pages/home_page.dart';
import 'package:baby/pages/authPages/login_page.dart';
import 'package:baby/provider/growth_infor_provider.dart';
import 'package:baby/provider/parent_provider.dart';
import 'package:baby/widget/avatar.dart';
import 'package:baby/widget/datepicker.dart';
import 'package:baby/widget/gender.dart';
import 'package:baby/widget/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


// Import the firebase_core and cloud_firestore plugin

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ParentProvider()),
        ChangeNotifierProvider(
          create: (context) => GrowthInforProvider(),
          child: const MyApp(),
        ),

        // Thêm các Provider khác nếu cần
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi', "VN")],
      //home: const HomePage(),
      home: const LoginPage(),
      //home: const GrowthInforPage(),
      //home: ,
    );
  }
}

