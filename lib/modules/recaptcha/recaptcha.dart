import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syriagames/modules/code_verification/code_verification.dart';
import 'package:syriagames/shared/components/components.dart';
import 'package:syriagames/shared/network/end_points.dart';
import 'package:syriagames/shared/network/remote/http_api.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:http/http.dart' as http;

class Captcha extends StatefulWidget {
  String phone;

  Captcha(this.phone);

  @override
  State<StatefulWidget> createState() {
    return CaptchaState(phone);
  }
}

class CaptchaState extends State<Captcha> {
  WebViewController? webViewController;
  String? phone;
  CaptchaState(this.phone);


  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewPlus(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (controller) {
        controller.loadUrl("assets/webpages/reCaptcha.html");
      },
      javascriptChannels: {
        JavascriptChannel(
            name: 'Captcha',
            onMessageReceived: (JavascriptMessage message) {
              // widget.callback(message.message);
              print('token : ${message.message}');
              print('phone : $phone');
              navigateTo(context, CodeVerificationScreen());

              Future<http.Response> response = HttpApi.postData(
                url: SEND_OTP_CODE,
                body: {
                  'g_recaptcha_response': message.message,
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
                  print(value.body);
                  print('True');
                } else {
                  print(value.body);
                  print('False');
                }
              });
              // Navigator.of(context).pop();
            })
      },
    );
  }
}
