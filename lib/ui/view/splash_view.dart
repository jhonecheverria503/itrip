import 'package:flutter/material.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';
import 'package:itrip/util/colors_app.dart';
import 'package:itrip/util/constants.dart';
import 'package:itrip/util/extension/permissions_app.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Future<void> startApp() async {
    await PermissionsApp.requestPermission();
    await Future.delayed(Duration(seconds: 2));
    bool savedSession =
        SessionManager.getInstance().getToken() != null &&
        (SessionManager.getInstance().getToken() ?? "").isNotEmpty;
    if (savedSession) {
      Navigator.of(
        Constants.navigatorKey.currentContext!,
      ).pushReplacementNamed("/home");
    } else {
      Navigator.of(
        Constants.navigatorKey.currentContext!,
      ).pushReplacementNamed("/login");
    }
  }

  @override
  void initState() {
    super.initState();
    startApp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsApp.primaryColor,
      child: Center(
        child: Image.asset(
          "asset/images/itrip_logo.png",
          width: 200,
          height: 72,
        ),
      ),
    );
  }
}
