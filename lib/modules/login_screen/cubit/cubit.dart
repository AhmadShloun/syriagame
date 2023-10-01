import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:syriagames/models/Auth/login_model.dart';
import 'package:syriagames/modules/login_screen/cubit/states.dart';
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  // LoginModel? loginModel;

  // void userLogin({
  //   @required String? email,
  //   @required String? password,
  // }) {
  //   print(email);
  //   emit(LoginLoadingState());
  //   Future<http.Response> response = HttpApi.postData(
  //     url: LOGIN,
  //     body: {
  //       'email': email,
  //       'password': password,
  //     },
  //   );
  //   response.then((value) {
  //     var jsonResponse = jsonDecode(value.body);
  //     loginModel = LoginModel.fromJson(jsonResponse);
  //     print('Data Model : ${value.body}');
  //     if (value.statusCode == 200) {
  //       emit(LoginSuccessState(loginModel!));
  //     } else {
  //       emit(LoginErrorState(loginModel!));
  //     }
  //   });
  //
  //
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
