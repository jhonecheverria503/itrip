import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itrip/ui/view/home_view.dart';
import 'package:itrip/ui/view/login_view.dart';
import 'package:itrip/ui/view/splash_view.dart';
import 'package:itrip/use_cases/bloc/login_bloc/login_bloc.dart';
import 'package:itrip/use_cases/bloc/trip_bloc/trip_bloc.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';
import 'package:itrip/util/colors_app.dart';
import 'package:itrip/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SessionManager().init();
  await SessionManager.getInstance().init();
  runApp(const ITrip());
}

class ITrip extends StatefulWidget {
  const ITrip({super.key});

  @override
  State<ITrip> createState() => _ITripState();
}

class _ITripState extends State<ITrip> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => TripBloc()),
        ],
        child: MaterialApp(
          title: "iTrip",
          routes: {
            '/login': (context) => const LoginView(),
            '/home': (context) => const HomeView(),
          },
          navigatorKey: Constants.navigatorKey,
          theme: ThemeData(
            brightness: Brightness.light,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorsApp.primaryDarkColor,
              selectionColor: ColorsApp.primaryColor,
              selectionHandleColor: ColorsApp.primaryDarkColor,
            ),
            primaryColor: ColorsApp.primaryColor,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorsApp.primaryDarkColor,
              selectionColor: ColorsApp.primaryColor.withOpacity(0.5),
              selectionHandleColor: ColorsApp.primaryDarkColor,
            ),
            primaryColor: ColorsApp.primaryColor,
          ),
          // ThemeData(primaryColor: ColorsApp.primaryColor),
          home: SplashView(),
        ),
      ),
    );
  }
}
