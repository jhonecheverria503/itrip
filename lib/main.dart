import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itrip/ui/view/home_view.dart';
import 'package:itrip/ui/view/login_view.dart';
import 'package:itrip/ui/view/splash_view.dart';
import 'package:itrip/use_cases/bloc/login_bloc/login_bloc.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';
import 'package:itrip/util/colors_app.dart';
import 'package:itrip/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SessionManager.getInstance().init();
  runApp(const Itrip());
}

class Itrip extends StatefulWidget {
  const Itrip({super.key});

  @override
  State<Itrip> createState() => _ItripState();
}

class _ItripState extends State<Itrip> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          
        ],
        child: MaterialApp(
          title: "iTrip",
          routes: {
            "/login": (context) => const LoginView(),
            "/home": (context) => const HomeView(),
          },
          navigatorKey: Constants.navigatorKey,
          theme: ThemeData(primaryColor: ColorsApp.primaryColor),
          home: const SplashView(),
        ),
      ),
    );
  }
}
