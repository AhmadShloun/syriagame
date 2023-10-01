

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:syriagames/models/Auth/Register_validation_model.dart';
import 'package:syriagames/models/Auth/register_model.dart';
import 'package:syriagames/modules/register_screen/cubit/states.dart';
import 'package:syriagames/shared/network/remote/http_api.dart';
import 'package:syriagames/shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  RegisterModel? registerModel;

  RegisterValidationModel? registerValidationModel;
  static RegisterCubit get(context) => BlocProvider.of(context);


  Errors? errors;
  void registerValidation({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirm_password,
  }) {
    emit(RegisterValidationLoadingState());
    Future<http.Response> response = HttpApi.postData(
      url: REGISTER_VALIDATION,
      body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confirm_password': confirm_password,
      },
      headers: {
        'Accept': 'application/json',
      },

    );
    response.then((value) {
      var jsonResponse = jsonDecode(value.body);
      registerValidationModel = RegisterValidationModel.fromJson(jsonResponse);
      print(2213);
      print(value.contentLength);
      if (value.statusCode == 200) {
        emit(RegisterValidationSuccessState(registerValidationModel!));
      } else {

        emit(RegisterValidationErrorState(registerValidationModel!));

      }
    });
  }


  // void userRegister({
  //   required String firstName,
  //   required String lastName,
  //   required String username,
  //   required String email,
  //   required String password1,
  //   required String password2,
  // }) {
  //   emit(RegisterLoadingState());
  //   Future<http.Response> response = HttpApi.postData(
  //     url: REGISTER_USER,
  //     body: {
  //       'first_name': firstName,
  //       'last_name': lastName,
  //       'username': username,
  //       'email': email,
  //       'password1': password1,
  //       'password2': password2,
  //     },
  //   );
  //   response.then((value) {
  //     var jsonResponse = jsonDecode(value.body);
  //     registerModel = RegisterModel.fromJson(jsonResponse);
  //     if (value.statusCode == 400) {
  //       print(value.statusCode);
  //       emit(RegisterErrorState(value.toString()));
  //     } else {
  //       print(value.statusCode);
  //       print(value.body);
  //       emit(RegisterSuccessState(registerModel!));
  //     }
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
