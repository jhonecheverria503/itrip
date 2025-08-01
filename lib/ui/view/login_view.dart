import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/ui/widget/common/colored_safe_area.dart';
import 'package:itrip/ui/widget/common/text_field_primary.dart';
import 'package:itrip/ui/widget/login/header_arc.dart';
import 'package:itrip/use_cases/bloc/login_bloc/login_bloc.dart';
import 'package:itrip/util/colors_app.dart';
import 'package:itrip/util/validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _ctrlEmail = TextEditingController();
  final TextEditingController _ctrlPassword = TextEditingController();
  final Validator _validator = Validator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is SuccessLoginState) {
            Navigator.of(context).pushReplacementNamed("/home");
          }
        },
        child: ColoredSafeArea(
          color: ColorsApp.primaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeaderArc(
                  child: Container(
                    color: ColorsApp.primaryColor,
                    height: MediaQuery.sizeOf(context).height / 3,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("asset/images/itrip_logo.png", width: 200),
                        const SizedBox(height: 32),
                        Image.asset("asset/images/beach.png", width: 192),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Form(
                      key: _keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bienvenido(a) ingresa tus datos",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFieldPrimary(
                            labelText: "Correo Electronico",
                            controller: _ctrlEmail,
                            autofillHints: [AutofillHints.newUsername],
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: _validator.validateEmail,
                          ),
                          const SizedBox(height: 16),
                          TextFieldPrimary(
                            labelText: "Contraseña",
                            controller: _ctrlPassword,
                            autofillHints: [AutofillHints.password],
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            validator: _validator.validatePassword,
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: ButtonPrimary(
                              text: 'Iniciar Sesión',
                              onClick: () async {
                                if (_keyForm.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    DoLoginEvent(
                                      email: _ctrlEmail.text,
                                      password: _ctrlPassword.text,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
