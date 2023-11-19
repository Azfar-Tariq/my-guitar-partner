import 'package:flutter/material.dart';
import 'package:my_guitar_partner/screens/forgot_password_screen.dart';
import 'package:my_guitar_partner/screens/home_screen.dart';
import 'package:my_guitar_partner/screens/reset_password_screen.dart';
import 'package:my_guitar_partner/screens/signin_screen.dart';
import 'package:my_guitar_partner/screens/signup_screen.dart';
import 'package:my_guitar_partner/screens/splash_screen.dart';
import 'package:my_guitar_partner/utils/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const SplashScreenWrapper(),
    );
  }
}

class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      navigateToMainScreen();
    });
  }

  void navigateToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MyAppContent(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

class MyAppContent extends StatelessWidget {
  const MyAppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Guitar Partner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      initialRoute: client.auth.currentSession != null ? '/home' : '/signup',
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
