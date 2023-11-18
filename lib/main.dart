import 'package:flutter/material.dart';
import 'package:my_guitar_partner/screens/forgot_password_screen.dart';
import 'package:my_guitar_partner/screens/home_screen.dart';
import 'package:my_guitar_partner/screens/reset_password_screen.dart';
import 'package:my_guitar_partner/screens/signin_screen.dart';
import 'package:my_guitar_partner/screens/signup_screen.dart';
import 'package:my_guitar_partner/utils/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://ourgxsocimxppailnxti.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im91cmd4c29jaW14cHBhaWxueHRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxOTMyODksImV4cCI6MjAxNTc2OTI4OX0.xMEmZSAE5vOiIH5w4btOBrkEML-RXqtquD37ljGG_Aw');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Guitar Partner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: client.auth.currentSession != null ? '/home' : '/signup',
      // initialRoute: '/signup',
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/reset': (context) => const ResetPasswordScreen(),
      },
    );
  }
}
