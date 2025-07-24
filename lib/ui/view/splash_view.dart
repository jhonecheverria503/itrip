import 'package:flutter/material.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';
import 'package:itrip/util/colors_app.dart';
import 'package:itrip/util/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> starApp() async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 2));
    bool sesionGuardada =
        SessionManager.getInstance().getToken() != null && (SessionManager.getInstance().getToken() ?? "").isNotEmpty;

        if(sesionGuardada){
          Navigator.of(Constants.navigatorKey.currentContext!).pushReplacementNamed("/home");
        }else{
          // Navigate to login view
          Navigator.of(Constants.navigatorKey.currentContext!).pushReplacementNamed("/login");
        }
    // Navigate to login view
    Navigator.of(Constants.navigatorKey.currentContext!).pushReplacementNamed("/login");
  }

  @override
  void initState() {
    starApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.primaryColor,
      child: Center(
        child: 
        (Image.asset(
          'asset/images/itrip_logo.png',
          width: 200,
        )),
      ),
    );
  }
} 