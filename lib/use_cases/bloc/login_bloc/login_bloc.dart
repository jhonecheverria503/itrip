import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:itrip/use_cases/singleton/session_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<DoLoginEvent>(_doLogin);
  }

  Future<void> _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginInitial());
    try {
      
      String url = "https://api.escuelajs.co/api/v1/auth/login";
      Map<String, String> headers = {"Content-Type": "application/json"};
      Map<String, String> body = {
        "email": event.email,
        "password": event.password,
      };
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
       if(response.statusCode == 201) {
        TextInput.finishAutofillContext();
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        await SessionManager.getInstance().setToken(responseBody["access_token"]);
        emit(SuccessLoginState());

       }else{
        emit(failedLoginState(message: response.statusCode==401 ?
            "Usuario o contraseña incorrectos" : "Error al iniciar sesión, intente más tarde"));
       }
    } catch (e) {
      emit(failedLoginState(message: "Ocurrio un error, intente más tarde"));
    }
  }
}
