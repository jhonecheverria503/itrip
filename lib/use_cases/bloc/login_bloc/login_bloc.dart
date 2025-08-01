import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:itrip/data/model/request/login_request.dart';
import 'package:itrip/data/model/response/login_response.dart';
import 'package:itrip/data/model/response/user_profile_response.dart';
import 'package:itrip/use_cases/singleton/session_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final String _urlBase = "https://api.escuelajs.co/api/v1/auth";
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<DoLoginEvent>(_doLogin);
  }

  Future<void> _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginState());
    try {
      LoginRequest loginRequest = LoginRequest(
        email: event.email,
        password: event.password,
      );
      http.Response response = await http.post(
        Uri.parse("$_urlBase/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginRequest.toJson()),
      );
      if (response.statusCode == 201) {
        TextInput.finishAutofillContext();
        LoginResponse loginResponse = LoginResponse.fromJson(
          jsonDecode(response.body),
        );
        if (loginResponse.accessToken != null) {
          await SessionManager.getInstance().setToken(
            loginResponse.accessToken!,
          );
        }
        http.Response responseUserProfile = await http.get(
          Uri.parse("$_urlBase/profile"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${loginResponse.accessToken}",
          },
        );
        UserProfileResponse userProfileResponse = UserProfileResponse.fromJson(
          jsonDecode(responseUserProfile.body),
        );
        await SessionManager.getInstance().setName(
          userProfileResponse.name ?? "",
        );
        await SessionManager.getInstance().setEmail(
          userProfileResponse.email ?? "",
        );
        await SessionManager.getInstance().setRole(
          userProfileResponse.role ?? "",
        );
        await SessionManager.getInstance().setPhotoUrl(
          userProfileResponse.avatar ?? "",
        );
        emit(SuccessLoginState());
      } else {
        emit(
          FailedLoginState(
            message: response.statusCode == 401
                ? "Email o contraseña erronea"
                : "Error al iniciar sesión, intente más tarde",
          ),
        );
      }
    } catch (e) {
      emit(FailedLoginState(message: 'Error inesperado: ${e.toString()}'));
    }
  }
}
