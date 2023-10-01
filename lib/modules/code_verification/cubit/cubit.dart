
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syriagames/modules/code_verification/cubit/states.dart';
import 'package:http/http.dart' as http;
import 'package:syriagames/shared/network/end_points.dart';
import 'package:syriagames/shared/network/remote/http_api.dart';

class CodeVerificationCubit extends Cubit<CodeVerificationStates> {
  CodeVerificationCubit() : super(CodeVerificationInitialState());
  static CodeVerificationCubit get(context) => BlocProvider.of(context);

  void sendCodeVerification({
    @required String? phone,
    @required String? token,
  }) {
    emit(CodeVerificationLoadingState());
    Future<http.Response> response = HttpApi.postData(
      url: SEND_OTP_CODE,
      body: {
        'g_recaptcha_response': token,
        'phone': phone,
      },
      headers: {
        'Accept': 'application/json',
      },
    );
    response.then((value) {
      // var jsonResponse = jsonDecode(value.body);
      // loginModel = LoginModel.fromJson(jsonResponse);
      // print('Data Model : ${value.body}');
      if (value.statusCode == 200) {
        print('True');
        emit(CodeVerificationSuccessState());
      } else {
        print('False');

        emit(CodeVerificationErrorState());
      }
    });


  }

}
