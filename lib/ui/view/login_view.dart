import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itrip/ui/widget/common/button_primary.dart';
import 'package:itrip/ui/widget/common/colored_safe_area.dart';
import 'package:itrip/ui/widget/login/header.arc.dart';
import 'package:itrip/use_cases/bloc/login_bloc/login_bloc.dart';
import 'package:itrip/util/colors_app.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _keyFom = GlobalKey<FormState>();
  final TextEditingController _ctrEmail = TextEditingController();
  final TextEditingController _ctrPassword = TextEditingController();
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
                      key: _keyFom,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bienvenido(a) ingresa tus datos",
                            style: TextStyle(
                              //color: ColorsApp.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _ctrEmail,
                            autofillHints: [AutofillHints.newUsername],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              //hintText: "Correo Electronico",
                              labelText: "Correo Electronico",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                if (RegExp(
                                  r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                                ).hasMatch(v)) {
                                  return null;
                                } else {
                                  return "El correo no es válido";
                                }
                              } else {
                                return "El correo es requerido";
                              }
                            },
                          ),

                          const SizedBox(height: 8),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _ctrPassword,
                            autofillHints: [AutofillHints.password],
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              //hintText: "Correo Electronico",
                              labelText: "Contraseña",
                            ),

                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                return null;
                              } else {
                                return "El correo es requerido";
                              }
                            },
                          ),

                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: ButtonPrimary(
                              onClick: () async {
                                if (_keyFom.currentState!.validate()) {
                                  // Aquí puedes manejar la lógica de inicio de sesión
                                  BlocProvider.of<LoginBloc>(context).add(
                                    DoLoginEvent(
                                      email: _ctrEmail.text,
                                      password: _ctrPassword.text,
                                    ),
                                  );
                                }
                              },
                              text: 'Iniciar Sesión',
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
