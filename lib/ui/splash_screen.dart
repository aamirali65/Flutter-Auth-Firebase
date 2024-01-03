import 'package:firebase/firebase_services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashService splashScreen = SplashService();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Firebase Tutorial',style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }
}
